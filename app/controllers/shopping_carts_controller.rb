class ShoppingCartsController < ApplicationController
  before_action :set_cart, only: [:show, :add_tee_time, :add_accessory]

  def show
    @cart
  end

  def add_tee_time
    @tee_time = TeeTime.find(params[:tee_time_id])

    @shopping_cart.update(tee_time: nil) if @shopping_cart.tee_time.present?

    if @shopping_cart.update(tee_time: @tee_time)
      flash[:notice] = "Tee time added to cart."
    else
      flash[:alert] = "Failed to add tee time to cart."
    end

    redirect_to shopping_cart_path(@shopping_cart)
  end

  def add_accessory
    @shopping_cart = current_user.shopping_cart
    @accessory = Accessory.find(params[:accessory_id])
    CombinedAccessory.create(accessory: @accessory, shopping_cart: @shopping_cart, price: @accessory.price, quantity: 1)
    flash[:notice] = "Accessory added to cart."

    redirect_to shopping_cart_path(@shopping_cart)
  end


  def set_cart
    @shopping_cart = current_user.shopping_cart
    Rails.logger.debug "Shopping Cart: #{@shopping_cart.inspect}"
  end

end
