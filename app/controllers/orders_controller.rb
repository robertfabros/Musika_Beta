# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:order_items, :province)
  end

  def show
    @order = current_user.orders.find(params[:id])
    @subtotal = @order.order_items.sum { |item| item.quantity * item.price }
    @gst = @subtotal * @order.province.gst
    @pst = @subtotal * @order.province.pst
    @qst = @subtotal * @order.province.qst
    @hst = @subtotal * @order.province.hst
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

  def pay
    @order = current_user.orders.find(params[:id])
    service = StripePaymentService.new(@order)
    session = service.create_checkout_session

    redirect_to session.url, allow_other_host: true
  end

  def success
    @order = current_user.orders.find(params[:id])
    @order.update(status: 'paid')
    redirect_to @order, notice: 'Payment was successfully processed.'
  end

  def cancel
    @order = current_user.orders.find(params[:id])
    redirect_to @order, alert: 'Payment was canceled.'
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
  def order_success_url(order)
    Rails.application.routes.url_helpers.order_url(order, action: 'success', host: '127.0.0.1', port: 3000)
  end

  def order_cancel_url(order)
    Rails.application.routes.url_helpers.order_url(order, action: 'cancel', host: '127.0.0.1', port: 3000)
  end
end
