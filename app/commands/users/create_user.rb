require 'bcrypt'

module Users
  class CreateUser < CommandBase
    contract do
      params do
        required(:email).filled(:string, format?: /@/)
        required(:password).filled(:string, min_size?: 8)
      end
    end

    private

    def execute
      password_digest = BCrypt::Password.create(context.validated_params[:password])
      user = User.create(
        email: context.validated_params[:email],
        password_digest: password_digest
      )

      context.object = user
      context.success = true
    end
  end
end
