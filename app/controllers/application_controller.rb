class ApplicationController < ActionController::Base

  private
  def current_cart
    if session[:cart_id]
      cart = ShoppingCart.find_by(id: session[:cart_id])
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    if session[:cart_id].nil?
      @current_cart = ShoppingCart.create(user_id: current_user.id)
      session[:cart_id] = @current_cart.id
    end

    @current_cart
  end
end
