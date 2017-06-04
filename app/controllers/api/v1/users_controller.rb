class Api::V1::UsersController < Api::V1::ApiController
  def index
    users = User.all
    render json: users
  end
  def show
    user = User.find_by(id: current_user.id)
    json_response(user)
  end
end
