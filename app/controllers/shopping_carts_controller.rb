class ShoppingCartsController < ApplicationController
  before_action :set_cart, only: [:show]
  def show

  end

  def create
    # Assuming the user is logged in and current_user is available
    @cart = current_cart
    @cart.tee_time_id = params[:tee_time_id]

    if @cart.save
      redirect_to shopping_cart_path(@cart), notice: 'Tee time was successfully added to the cart.'
    else
      redirect_to tee_times_path, alert: 'Unable to add tee time to the cart.'
    end
  end

  private

  def set_cart
    @cart = current_cart
    unless @cart
      redirect_to root_path, alert: 'Cart not found'
    end
  end

    def destroy
      @cart = @current_cart
      @cart.destroy
      session[cart_id] = nil
      redirect_to root_path
  end
end
