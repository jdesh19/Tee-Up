class ShoppingCartsController < ApplicationController
  before_action :set_cart, only: [:show, :add_tee_time, :remove_tee_time, :add_accessory, :remove_accessory]

  def show
    @accessories = Accessory.all
    @combined_accessories = @shopping_cart.combined_accessories.includes(:accessory)
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
    accessory_id = params[:accessory_id].to_i
    quantity = params[:quantity].to_i

    current_total_quantity = @shopping_cart.combined_accessories.sum(:quantity)

    if current_total_quantity + quantity > 4
      flash[:alert] = "Cannot add more than 4 carts in total to the order."
    else
      combined_accessory = @shopping_cart.combined_accessories.find_or_initialize_by(accessory_id: accessory_id)
      combined_accessory.quantity = (combined_accessory.quantity || 0) + quantity
      combined_accessory.price = Accessory.find(accessory_id).price

      if combined_accessory.save
        flash[:notice] = "Accessory added to cart."
      else
        flash[:alert] = "Failed to add accessory to cart."
      end
    end

    redirect_to shopping_cart_path(@shopping_cart)
  end

  def remove_accessory
    combined_accessory = @shopping_cart.combined_accessories.find_by(accessory_id: params[:accessory_id])
    combined_accessory.destroy if combined_accessory

    redirect_to shopping_cart_path(@shopping_cart), notice: 'Accessory removed from cart.'
  end

  def set_cart
    @shopping_cart = current_user.shopping_cart || current_user.create_shopping_cart
  end

end
