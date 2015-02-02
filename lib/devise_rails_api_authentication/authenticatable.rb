require 'devise'

module DeviseRailsApiAuthentication
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      devise :database_authenticatable, :trackable
      before_save :ensure_authentication_token
    end

    def ensure_authentication_token
      return unless authentication_token.blank?

      self.authentication_token = generate_authentication_token
    end

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token if self.class.where(authentication_token: token).count == 0
      end
    end
  end
end
