require 'sequel'
require 'sequel/extensions/migration'

# ENV
require_relative 'config/load_env'
# Настройка подключения к базе данных
require_relative 'config/database'

require_relative 'config/initializers/sneakers'

# TODO доработать загрузку всех воркеров
require_relative 'app/workers/user_worker'

namespace :db do
  task :migrate do
    Sequel::Migrator.run(DB.connect, 'db/migrations')
  end

  task :rollback do
    Sequel::Migrator.run(DB.connect, 'db/migrations', target: (Sequel::Migrator.apply(DB.connect, 'db/migrations', :down) - 1))
  end
end

namespace :sneakers do
  task :start do
    workers = %w[UserWorker]

    workers.each do |worker|
      fork do
        Object.const_get(worker).new.run
      end
    end

    # Ожидание завершения всех процессов
    Process.waitall
  end
end
