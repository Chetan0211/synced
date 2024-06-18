class SigningController < ApplicationController
  def new
    @user_data = flash.now[:user_data] || {}
    @errors = flash.now[:errors] || {}
  end

  def create
    @user_data = params[:signing_user] || {}  # Ensure @user_data is always a hash
    @errors = {}
    user = user_params
    administration = administration_params
    user[:user_type] = "admin"
    user[:email]  = user[:email] + "@" + administration[:email_identifier]
    result = Signing::Create.call(user: user, administration: administration)
    if result.success?
      # Do something on success
    else
      flash.now[:user_data] = @user_data
      flash.now[:errors] = @errors = result['contract.default'].errors
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:signing_user).permit(:first_name, :last_name, :personal_email, :email, :password, :confirm_password)
    
  end

  def transform_params(params, key_mapping)
    params.transform_keys { |key| key_mapping[key.to_sym] || key }
  end

  def administration_params
    original_params = params.require(:signing_user).permit(:name, :email_identifier, :personal_email)
    transform_params(original_params, { personal_email: :email })
  end
end
