# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items
  end

  def add_to_cart
    @cart_item = @cart.cart_items.find_or_initialize_by(music_id: params[:music_id])
    @cart_item.quantity ||= 0
    @cart_item.quantity += 1
    @cart_item.price = @cart_item.music.price

    if @cart_item.save
      redirect_to cart_path, notice: 'Item added to cart.'
    else
      redirect_to musics_path, alert: 'Unable to add item to cart.'
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
