class PaymentsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :set_shopping_cart

  def create_payment
    items = @shopping_cart.combined_accessories.map do |combined_accessory|
      accessory = combined_accessory.accessory
      {
        name: accessory.product,
        sku: accessory.product,
        price: (accessory.price.to_f / 100).round(2).to_s, # Convert cents to dollars
        currency: "CAD",
        quantity: combined_accessory.quantity.to_i
      }
    end

    if @shopping_cart.tee_time
      items << {
        name: "Tee Time",
        sku: "tee_time",
        price: (@shopping_cart.tee_time.price.to_f / 100).round(2).to_s, # Convert cents to dollars
        currency: "CAD",
        quantity: 1
      }
    end

    subtotal = items.sum { |item| item[:price].to_f * item[:quantity].to_i }.round(2)

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
          total: total_price.to_s,
          currency: "CAD",
          details: {
            subtotal: subtotal.to_s,
            tax: total_tax.to_s
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

    if payment.execute(payer_id: params[:PayerID])
      @shopping_cart = current_user.shopping_cart

      Order.create!(
        user_id: current_user.id,
        tee_time_id: @shopping_cart.tee_time_id,
        total_price: payment.transactions.first.amount.total,
        combined_accessory_id: @shopping_cart.combined_accessory_ids
      )

      @shopping_cart.combined_accessories.destroy_all

      redirect_to root_path
    else
      render :error
    end
  end


  private

  def set_shopping_cart
    @shopping_cart = current_user.shopping_cart || ShoppingCart.create(user: current_user)
  end
end
