# app/controllers/cart_items_controller.rb
class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart || current_user.create_cart
    @cart_item = @cart.cart_items.find_or_initialize_by(music_id: params[:music_id])
    @cart_item.quantity += 1
    @cart_item.price = @cart_item.music.price

    if @cart_item.save
      redirect_to cart_path, notice: 'Item added to cart.'
    else
      redirect_to musics_path, alert: 'Unable to add item to cart.'
    end
  end

  def update
    @cart_item = current_user.cart.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Cart item updated.'
    else
      redirect_to cart_path, alert: 'Unable to update cart item.'
    end
  end

  def destroy
    @cart_item = current_user.cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Cart item removed.'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end

# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items
  end

  def add_to_cart
    Rails.logger.debug "Current user: #{current_user.inspect}"
    Rails.logger.debug "User's cart: #{current_user.cart.inspect if current_user.respond_to?(:cart)}"
    @cart_item = @cart.cart_items.find_or_initialize_by(music_id: params[:music_id])
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
    Rails.logger.debug "Set cart: #{@cart.inspect}"
  end
end
