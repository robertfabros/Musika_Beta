# app/services/stripe_payment_service.rb
class StripePaymentService
  def initialize(order)
    @order = order
  end

  def create_checkout_session(success_url, cancel_url)
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
      success_url: success_url,
      cancel_url: cancel_url,
    )
  end
end
