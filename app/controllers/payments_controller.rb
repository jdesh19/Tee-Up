class PaymentsController < ApplicationController
  before_action :set_shopping_cart

  def create_payment
    items = @shopping_cart.combined_accessories.map do |combined_accessory|
      accessory = combined_accessory.accessory
      {
        name: accessory.product,
        sku: accessory.product,
        price: format('%.2f', accessory.price.to_f / 100),
        currency: "CAD",
        quantity: combined_accessory.quantity.to_i
      }
    end

    if @shopping_cart.tee_time
      items << {
        name: "Tee Time",
        sku: "tee_time",
        price: format('%.2f', @shopping_cart.tee_time.price.to_f / 100),
        currency: "CAD",
        quantity: 1
      }
    end


    subtotal = items.sum { |item| item[:price].to_f * item[:quantity].to_i }
    tax = current_user.province.total_tax_rate
    total_tax = (subtotal * tax).round(2)
    total_price = (subtotal + total_tax).round(2)

    @payment = PayPal::SDK::REST::Payment.new({
      intent: "sale",
      payer: {
        payment_method: "paypal"
      },
      redirect_urls: {
        return_url: "http://127.0.0.1:3000/execute",
        cancel_url: "http://127.0.0.1:3000/cancel"
      },
      transactions: [{
        item_list: {
          items: items
        },
        amount: {
          total: format('%.2f', total_price),
          currency: "CAD",
          details: {
            subtotal: format('%.2f', subtotal),
            tax: format('%.2f', total_tax)
          }
        },
        description: "Booking fee for tee time and accessories."
      }]
    })

    if @payment.create
      redirect_url = @payment.links.find { |v| v.method == "REDIRECT" }.href
      redirect_to redirect_url, allow_other_host: true
    else
      render json: @payment.error
    end
  end

  def execute_payment
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
    total_price_in_cents = (payment.transactions.first.amount.total.to_f * 100).round

    if payment.execute(payer_id: params[:PayerID])
      @shopping_cart = current_user.shopping_cart

      @order = Order.create!(
        user_id: current_user.id,
        tee_time_id: @shopping_cart.tee_time_id,
        total_price: total_price_in_cents,

      )


      @shopping_cart.combined_accessories.each do |combined_accessory|
        CombinedAccessory.create!(
          accessory_id: combined_accessory.accessory_id,
          quantity: combined_accessory.quantity,
          price: combined_accessory.price,
          order_id: @order.id
        )
      end

      @shopping_cart.combined_accessories.destroy_all

      redirect_to success_path(order_id: @order.id)
    else
      render :error
    end
  end


  def success
    @order = Order.find(params[:order_id])
    @shopping_cart = current_user.shopping_cart
    @combined_accessories = CombinedAccessory.where(order_id: @order.id)
  end

  private

  def set_shopping_cart
    @shopping_cart = current_user.shopping_cart || ShoppingCart.create(user: current_user)
  end
end
