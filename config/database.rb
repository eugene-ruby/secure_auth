# Подключение к PostgreSQL
module DB
  def self.connect
    @db ||= Sequel.connect(ENV['DATABASE_URL'])
  end
end

DB.connect

# Подключение миграций
# Sequel.extension :migration
# Sequel::Migrator.run(DB.connect, 'db/migrations') if ENV['RACK_ENV'] == 'development'

Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :json_serializer