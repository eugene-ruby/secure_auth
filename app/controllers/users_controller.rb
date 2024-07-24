class UsersController < BaseController
  before do
    # protected!
  end

  get '/users' do
    users = User.all
    users.to_json
  end

  post '/users' do
    result = Users::CreateUser.new.call(params: json_params)
    halt_error(result) if result.context.failure?

    status 201
    Users::UserPresenter.new(result.context.object).to_json
  end

  get '/users/:id' do
    result = Users::ShowUser.new.call(params: params)
    halt_error(result) if result.context.failure?

    Users::UserPresenter.new(result.context.object).to_json
  end

  put '/users/:id' do
    contract = Contracts::UserContract.new
    valid_params = validate_contract!(contract, json_params)

    # Создаем зашифрованный пароль
    password_digest = BCrypt::Password.create(valid_params[:password])

    user = User[params[:id]]
    halt(404, { message: 'User Not Found' }.to_json) unless user
    if user.update(email: valid_params[:email], password_digest: password_digest)
      status 200
      user.to_json
    else
      status 422
      user.errors.to_json
    end
  end

  delete '/users/:id' do
    user = User[params[:id]]
    halt(404, { message: 'User Not Found' }.to_json) unless user
    user.destroy
    status 204
  end
end
