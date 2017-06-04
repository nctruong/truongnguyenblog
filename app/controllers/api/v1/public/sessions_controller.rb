class Api::V1::Public::SessionsController < Devise::SessionsController
  include Devise::Controllers::Helpers
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless user
    if user.valid_password?(params[:password])
      sign_in("user", user)
      render(json: {success: true, auth_token: user.api_token, login: user.email})
      return
    end
    invalid_login_attempt
  end

  def destroy
    user = User.find_by(id: warden.user.id)
    sign_out(user)
    render json: {success: true, message: "Signed out"}
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render(json: {success: false, message: "Error with your login or password"}, status: 401)
  end

  private
  def create_params
    params.permit(:email, :password)
  end
end
