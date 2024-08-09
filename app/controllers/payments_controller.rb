class PaymentsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :set_shopping_cart

  def create_payment
    items = @shopping_cart.combined_accessories.map do |combined_accessory|
      accessory = combined_accessory.accessory
      {
        name: accessory.product,
        sku: accessory.product,
        price: accessory.price.to_f, # Ensure price is a float
        currency: "CAD",
        quantity: combined_accessory.quantity.to_i # Ensure quantity is an integer
      }
    end

    if @shopping_cart.tee_time
      items << {
        name: "Tee Time",
        sku: "tee_time",
        price: @shopping_cart.tee_time.price.to_f, # Ensure price is a float
        currency: "CAD",
        quantity: 1
      }
    end

    total_amount = items.sum { |item| item[:price] * item[:quantity] }
    formatted_total_amount = sprintf('%.2f', total_amount)

    Rails.logger.debug "Items: #{items.inspect}"
    Rails.logger.debug "Total Amount: #{formatted_total_amount}"

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
          total: formatted_total_amount,
          currency: "CAD"
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

      # Create the order
      order = Order.create!(
        user_id: current_user.id,
        tee_time_id: @shopping_cart.tee_time_id,
        total_amount: payment.transactions.first.amount.total,
        status: 'completed' # You might want to add a status attribute
      )

      # Create OrderItems for each accessory in the shopping cart
      @shopping_cart.combined_accessories.each do |combined_accessory|
        OrderItem.create!(
          order_id: order.id,
          accessory_id: combined_accessory.accessory_id,
          quantity: combined_accessory.quantity, # Ensure this attribute is available
          price: combined_accessory.accessory.price # Ensure you have a price attribute in Accessory
        )
      end

      # Optionally clear the shopping cart after creating the order
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
