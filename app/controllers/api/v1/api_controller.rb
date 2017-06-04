class Api::V1::ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  # before_action :authenticate_user!
  before_filter :authenticate
  after_action :set_csrf_cookie_for_ng

  STATUS                        = 'status'
  MESSAGE                       = 'message'
  POINT                         = 'point'
  DATA                          = 'data'
  CONFIG                        = 'config'
  STATUS_OK                     = 200
  STATUS_BAD_REQUEST            = 400
  STATUS_UNAUTHORIZED           = 401
  STATUS_INTERNAL_SERVER_ERROR  = 500

  rescue_from Exception, with: :error_500

  rescue_from Exception do |exception|
    logger.error exception.message
    response = {}
    response[STATUS] = STATUS_INTERNAL_SERVER_ERROR
    response[MESSAGE] = I18n.t('api.exception')
    response[DATA] = nil
    render json: response, status: STATUS_INTERNAL_SERVER_ERROR
  end

  def locale
    I18n.locale = :en
  end

  def sessionate(user)
    session[:user_id] = user.id
  end

  def desessionate
    session[:user_id] = nil
    @current_user = nil
  end

  def authenticate
    if current_user.blank?
      response = {}
      response[STATUS] = STATUS_UNAUTHORIZED
      response[MESSAGE] = I18n.t('api.authentication_required')
      response[DATA] = nil
      render json: response, status: STATUS_UNAUTHORIZED
    end
  end

  def current_user
    if (api_token = request.headers['HTTP_API_TOKEN']).present?
      @current_user ||= User.find_by(api_token: api_token)
    end
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end
end
