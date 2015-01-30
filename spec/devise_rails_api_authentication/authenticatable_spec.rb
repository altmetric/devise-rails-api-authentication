require 'spec_helper'

RSpec.describe DeviseRailsApiAuthentication::Authenticatable do
  subject(:user) { User.new }

  describe '#ensure_authentication_token' do
    it 'generates a token if not given' do
      expect { user.save }.to change { user.authentication_token }.from(nil)
    end

    it 'does not generate a token if given' do
      user.authentication_token = 'test'
      expect { user.save }.not_to change { user.authentication_token }
    end

    it 'generates a new token if one is taken' do
      expect(Devise).to receive(:friendly_token).and_return('1', '2')

      another_user = User.create(authentication_token: '1')
      expect { user.save }.to change { user.authentication_token }.to('2')
    end
  end
end

