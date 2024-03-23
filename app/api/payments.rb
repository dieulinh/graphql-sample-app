class Payments < Grape::API
  include Shared::AuthorizationKit
  namespace :checkout do
    params do
      requires :items, type: Array[Hash]
    end
    post '/createpayment_intent' do
      authenticate_user!
      course_info = params[:items].first
      course_id = course_info['course_id']
      student_id = course_info['user_id']
      checkout = Checkout.find_by(checkout_id: "course_#{course_id}", student_id: student_id.to_i)
      # rack_response({"status"=>409, "message"=>"Duplicated."}) if checkout
      render_api_error!('409 Precondition Failed', 409) if checkout

      course_price = course_info['price']

      payment_intent = Stripe::PaymentIntent.create(
        amount: course_price*100,
        currency: 'usd',
        # In the latest version of the API, specifying the `automatic_payment_methods` parameter is optional because Stripe enables its functionality by default.
        automatic_payment_methods: {
          enabled: true,
        })
      client_secret = payment_intent.client_secret
      Checkout.create(client_secret: client_secret, checkout_id: "course_#{course_id}", student_id: student_id.to_i)
      {
        clientSecret: client_secret,
      }.as_json
    end
    params do
      optional :payment_intent, type: String
      optional :course_id, type: String
      optional :redirect_status, type: String
      requires :payment_intent_client_secret, type: String
    end

    post '/process_checkout_status' do
      authenticate_user!
      checkout = Checkout.find_by client_secret: params[:payment_intent_client_secret]
      checkout.update redirect_status: params[:redirect_status]
      if params[:redirect_status] == 'succeeded'
        student = current_user
        create_course_user(course_id: params[:course_id], student: student)
      end
    end
  end
end
