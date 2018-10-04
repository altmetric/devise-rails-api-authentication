require 'devise'

module DeviseRailsApiAuthentication
  module Context
    extend ActiveSupport::Concern

    included do
      include Devise::Controllers::Helpers
      include ActionController::RespondWith
      before_action :authenticate_user_from_token!
    end

    def authenticate_user_from_token!
      return if Rails.env.development?

      if user && Devise.secure_compare(user.authentication_token, user_token)
        warden.set_user(user, scope: :user, store: false)
      else
        not_authenticated_error
      end
    end

    def user_email
      request.headers['HTTP_X_USER_EMAIL']
    end

    def user_token
      request.headers['HTTP_X_USER_TOKEN']
    end

    def not_authenticated_error
      response.headers['WWW-Authenticate'] = 'Token'
      head status: 401
    end

    def user
      raise NotImplementedError
    end
  end
end
