class Company < Sequel::Model
  many_to_many :users, join_table: :companies_users
end