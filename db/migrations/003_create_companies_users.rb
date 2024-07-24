Sequel.migration do
  up do
    create_table(:companies_users) do
      uuid :company_id, null: false
      uuid :user_id, null: false
      primary_key [:company_id, :user_id]

      foreign_key [:company_id], :companies, on_delete: :cascade
      foreign_key [:user_id], :users, on_delete: :cascade
    end
  end

  down do
    drop_table :companies_users
  end
end
