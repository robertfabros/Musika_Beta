class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:order_items, :province)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = current_user.orders.build
    @provinces = Province.all
    @cart_items = current_user.cart.cart_items
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = 'pending'
    @order.total_price = calculate_total_price
    @cart_items = current_user.cart.cart_items

    if @order.save
      @cart_items.each do |item|
        @order.order_items.create!(
          music_id: item.music_id,
          quantity: item.quantity,
          price: item.price
        )
      end
      current_user.cart.cart_items.destroy_all
      session[:cart] = []
      redirect_to order_path(@order), notice: 'Order was successfully created.'
    else
      @provinces = Province.all
      render :new, alert: 'Failed to create order.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:province_id)
  end

  def calculate_total_price
    cart_items = current_user.cart.cart_items
    subtotal = cart_items.sum { |item| item.quantity * item.price }
    gst = subtotal * current_user.province.gst
    pst = subtotal * current_user.province.pst
    qst = subtotal * current_user.province.qst
    hst = subtotal * current_user.province.hst
    subtotal + gst + pst + qst + hst
  end
end
