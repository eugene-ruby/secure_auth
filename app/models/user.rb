class User < Sequel::Model
  many_to_many :companies, join_table: :companies_users

  plugin :validation_helpers

  def validate
    super
    validates_presence [:email, :password_digest]
    validates_unique :email
    validates_format /@/, :email
  end
end