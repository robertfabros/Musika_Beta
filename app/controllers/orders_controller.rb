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
    session = service.create_checkout_session(order_success_url(@order) + "?session_id={CHECKOUT_SESSION_ID}", order_cancel_url(@order))

    redirect_to session.url, allow_other_host: true
  end

  def success
    @order = current_user.orders.find(params[:id])
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @order.update(status: 'paid', stripe_payment_id: stripe_session.payment_intent)
    render 'success'
  end

  def cancel
    @order = current_user.orders.find(params[:id])
    render 'cancel'
  end

  private

  def order_params
    params.require(:order).permit(:province_id)
  end

  def calculate_total_price
    cart_items = current_user.cart.cart_items
    subtotal = cart_items.sum { |item| item.quantity * item.price }
    province = Province.find(order_params[:province_id])
    gst = subtotal * province.gst
    pst = subtotal * province.pst
    qst = subtotal * province.qst
    hst = subtotal * province.hst
    subtotal + gst + pst + qst + hst
  end

  def order_success_url(order)
    Rails.application.routes.url_helpers.success_order_url(order, host: '127.0.0.1', port: 3000)
  end

  def order_cancel_url(order)
    Rails.application.routes.url_helpers.cancel_order_url(order, host: '127.0.0.1', port: 3000)
  end
end
