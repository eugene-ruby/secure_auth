Sequel.migration do
  up do
    create_table(:companies) do
      uuid :id, primary_key: true, default: Sequel.lit('gen_random_uuid()')
      String :name, null: false
      Boolean :active, default: true
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table :companies
  end
end
