# Подключение основных файлов приложения
require './app'

# Конфигурация среды выполнения
configure do
  set :environment, ENV['RACK_ENV'] || :development
end

configure :development do
  # Отключить стандартное поведение трассировки стека
  # set :show_exceptions, false
  # set :show_exceptions, :after_handler
  # set :show_exceptions, :custom_handler
end

# Запуск приложения
run SecureAuthApp
