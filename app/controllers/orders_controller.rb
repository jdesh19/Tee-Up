class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @shopping_cart = current_user.shopping_cart
    @order = Order.new(user: current_user, tee_time: @shopping_cart.tee_time, total_price: @shopping_cart.total, item_quantity: @shopping_cart.items)

    if @order.save
      @shopping_cart.combined_accessories.each do |ca|
        CombinedAccessory.create(accessory: ca.accessory, order: @order, price: ca.price, quantity: ca.quantity)
      end
      @shopping_cart.destroy
      flash[:notice] = "Order placed successfully."
      redirect_to order_path(@order)
    else
      flash[:alert] = "There was a problem placing your order."
      redirect_to shopping_cart_path(@shopping_cart)
    end
  end

  private
  def order_params
    params.require(:order).permit(:full_name, :email, :address, :province_id)
  end
end
