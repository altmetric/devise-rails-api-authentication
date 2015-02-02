ENV['RACK_ENV'] = 'test'
require 'rails-api'
require 'rspec/rails'

require_relative '../lib/devise_rails_api_authentication'

require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.connection.execute <<-SQL
  CREATE TABLE users (
    id INTEGER,
    email TEXT,
    authentication_token TEXT
  )
SQL
ActiveRecord::Base.extend Devise::Models

class User < ActiveRecord::Base
  include DeviseRailsApiAuthentication::Authenticatable
end
