# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_to_cart, :remove_from_cart, :update_cart]

  def show
    @cart_items = merge_cart_items
  end

  def add_to_cart
    session[:cart] ||= []
    item = session[:cart].find { |i| i["music_id"] == params[:music_id].to_i }
    if item
      item["quantity"] += 1
    else
      music = Music.find(params[:music_id])
      session[:cart] << { "music_id" => music.id, "quantity" => 1, "title" => music.title, "price" => music.price }
    end

    # Update the database
    cart_item = @cart.cart_items.find_or_initialize_by(music_id: params[:music_id])
    cart_item.quantity = cart_item.quantity ? cart_item.quantity + 1 : 1
    cart_item.price = cart_item.music.price
    cart_item.save

    redirect_to cart_path
  end

  def remove_from_cart
    session[:cart].reject! { |item| item["music_id"] == params[:music_id].to_i }

    # Remove from the database
    cart_item = @cart.cart_items.find_by(music_id: params[:music_id])
    cart_item&.destroy

    redirect_to cart_path
  end

  def update_cart
    item = session[:cart].find { |i| i["music_id"] == params[:music_id].to_i }
    if item
      item["quantity"] = params[:quantity].to_i
    end

    # Update the database
    cart_item = @cart.cart_items.find_by(music_id: params[:music_id])
    if cart_item
      cart_item.quantity = params[:quantity].to_i
      cart_item.save
    end

    redirect_to cart_path
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def merge_cart_items
    session_items = session[:cart] || []
    db_items = @cart.cart_items.map do |item|
      { "music_id" => item.music_id, "quantity" => item.quantity, "title" => item.music.title, "price" => item.price }
    end

    # Merge session and database items, prioritize database items if they exist
    merged_items = db_items
    session_items.each do |s_item|
      unless merged_items.any? { |m_item| m_item["music_id"] == s_item["music_id"] }
        merged_items << s_item
      end
    end
    merged_items
  end
end
