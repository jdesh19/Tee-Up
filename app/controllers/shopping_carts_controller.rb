class ShoppingCartsController < ApplicationController
  before_action :set_cart, only: [:show, :add_tee_time, :add_accessory, :remove_tee_time]

  def show
  end

  def add_tee_time
    @tee_time = TeeTime.find(params[:tee_time_id])

    if @shopping_cart.tee_time.present?
      @shopping_cart.update(tee_time: nil)
    end

    @shopping_cart.update(tee_time: @tee_time)
    flash[:notice] = "Tee time added to cart."

    redirect_to shopping_cart_path(@shopping_cart)
  end

  def remove_tee_time
    @shopping_cart = current_user.shopping_cart

    if @shopping_cart.tee_time.present?
      if @shopping_cart.destroy
        flash[:notice] = "Tee time removed from cart."
      else
        flash[:alert] = "Can't Remove from cart"
      end
    else
      flash[:alert] = "Cart Empty"
    end

    redirect_to root_path
  end

  def add_accessory
    @shopping_cart = current_user.shopping_cart
    @accessory = Accessory.find(params[:accessory_id])
    CombinedAccessory.create(accessory: @accessory, shopping_cart: @shopping_cart, price: @accessory.price, quantity: 1)
    flash[:notice] = "Accessory added to cart."

    redirect_to shopping_cart_path(@shopping_cart)
  end


  def set_cart
    @shopping_cart = current_user.shopping_cart || current_user.create_shopping_cart
  end

end
