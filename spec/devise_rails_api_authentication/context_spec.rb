require 'spec_helper'
require 'ostruct'

class TestController
  def self.before_action(*_); end
  def self.helper_method(*_); end

  include DeviseRailsApiAuthentication::Context

  def request
    @_request ||= OpenStruct.new(headers: {})
  end

  def response
    @_response ||= OpenStruct.new(headers: {}, status: 200)
  end

  def head(opts)
    opts.each { |k, v| response.send("#{k}=", v) }
  end

  def index
    authenticate_user_from_token!
    response
  end

  private

  def user
    User.where(email: user_email).first
  end
end

RSpec.describe TestController do
  let(:user) { User.create(email: 'test@altmetric.com') }
  let(:warden) { double(Warden::Proxy) }
  subject(:context) { described_class.new }
  subject(:response) { context.index }

  context 'no auth token' do
    it 'should get 401 Unauthorized' do
      expect(response.status).to eq(401)
    end

    it 'should unauthorized header' do
      expect(response.headers).to eq('WWW-Authenticate' => 'Token')
    end
  end

  context 'with auth token' do
    before do
      context.request.headers['HTTP_X_USER_EMAIL'] = user.email
      context.request.headers['HTTP_X_USER_TOKEN'] = user.authentication_token
      allow(context)
        .to receive(:warden)
        .and_return(warden)
      allow(warden)
        .to receive(:set_user)
        .with(kind_of(User), hash_including(store: false))
        .and_return(true)
    end

    it 'should get 200 OK' do
      expect(response.status).to eq(200)
    end
  end
end
