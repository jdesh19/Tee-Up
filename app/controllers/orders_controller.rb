class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  private
  def order_params
    params.require(:order).permit(:full_name, :email, :address, :province_id)
  end
end
