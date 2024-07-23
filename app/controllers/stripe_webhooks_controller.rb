class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook_secret)
      )
    rescue JSON::ParserError => e
      render json: { message: 'Invalid payload' }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      render json: { message: 'Invalid signature' }, status: :bad_request
      return
    end

    case event['type']
    when 'checkout.session.completed'
      handle_checkout_session_completed(event['data']['object'])
    end

    render json: { message: 'success' }
  end

  private

  def handle_checkout_session_completed(session)
    order = Order.find_by(id: session.client_reference_id)
    return unless order

    order.update(status: 'paid')
    # Trigger additional actions like sending a confirmation email if needed
  end
end
