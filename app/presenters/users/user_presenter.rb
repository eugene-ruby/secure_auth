require_relative '../base_presenter'

module Users
  class UserPresenter < BasePresenter
    def to_json
      {
        id: @object.id,
        email: @object.email,
        created_at: @object.created_at,
        updated_at: @object.updated_at
      }.to_json
    end
  end
end