class HomeController < ApplicationController
  def index
    # ExampleJob.set(wait: 20.seconds).perform_later('Alice', 5)
    # ExampleMailer.welcome_user("Sai Chetan").deliver_now
    # result = Braintree::Transaction.sale(
    #   amount: params[:transaction][:amount],
    #   payment_method_nonce: params[:payment_method_nonce]
    # )

    # if result.success?
    #   # Handle successful transaction
    #   ExampleJob.set(wait: 20.seconds).perform_later('Alice', 5)
    # else
    #   # Handle failed transaction
    # end 
    
    jwt_token = JsonWebToken.encode(user_id: "akjansdjanjas")
    debugger
  end
end
