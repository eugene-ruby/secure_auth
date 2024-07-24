require 'bcrypt'

module Users
  class ShowUser < CommandBase
    contract do
      params do
        required(:id).filled(:uuid_v4?)
      end
    end

    private

    def execute
      context.object = User[context.params[:id]]
    end
  end
end
