# app/services/stripe_payment_service.rb
class StripePaymentService
  def initialize(order)
    @order = order
  end

  def create_checkout_session
    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'cad',
          product_data: {
            name: "Order ##{@order.id}",
          },
          unit_amount: (@order.total_price * 100).to_i,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: Rails.application.routes.url_helpers.order_url(@order, host: default_url_options[:host]),
      cancel_url: 'http://127.0.0.1:3000/',
    )
  end

  private

  def default_url_options
    if Rails.env.production?
      { host: 'your-production-domain.com' }
    else
      { host: 'localhost', port: 3000 }
    end
  end
end
