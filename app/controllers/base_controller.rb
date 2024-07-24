require 'sinatra/base'
require 'json'
require 'jwt'

class BaseController < Sinatra::Base
  configure do
    enable :logging
  end

  before do
    content_type :json
  end

  helpers do
    def halt_error(result, code: 422)
      status code
      halt code, { error: result.context.errors }.to_json
    end

    def json_params
      begin
        JSON.parse(request.body.read, symbolize_names: true)
      rescue JSON::ParserError
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end

    def protected!
      return if authorized?
      halt 401, { message: 'Unauthorized' }.to_json
    end

    def authorized?
      token = request.env["HTTP_AUTHORIZATION"]
      return false unless token
      begin
        payload, _ = JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
        @current_user = User[payload["user_id"]]
      rescue JWT::DecodeError
        false
      end
    end

    def validate_contract!(contract, params)
      result = contract.call(params)
      if result.failure?
        halt 422, { errors: result.errors.to_h }.to_json
      end
      result.to_h
    end
  end

  error Sequel::NoMatchingRow do
    halt 404, { message: 'Record Not Found' }.to_json
  end

  error Sequel::ValidationFailed do |e|
    halt 422, { message: e.message }.to_json
  end

  error do
    halt 500, { message: 'Internal Server Error' }.to_json
  end
end
