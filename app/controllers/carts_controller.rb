# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_to_cart, :remove_from_cart, :update_cart]

  def show
    @cart_items = session[:cart] || []
    @db_cart_items = @cart.cart_items if @cart.present?
  end

  def add_to_cart
    session[:cart] ||= []
    item = session[:cart].find { |i| i["music_id"] == params[:music_id] }
    if item
      item["quantity"] += 1
    else
      music = Music.find(params[:music_id])
      session[:cart] << { "music_id" => music.id, "quantity" => 1, "title" => music.title, "price" => music.price }
    end
    redirect_to cart_path
  end

  def remove_from_cart
    session[:cart].reject! { |item| item["music_id"] == params[:music_id] }
    redirect_to cart_path
  end

  def update_cart
    item = session[:cart].find { |i| i["music_id"] == params[:music_id] }
    if item
      item["quantity"] = params[:quantity].to_i
    end
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
