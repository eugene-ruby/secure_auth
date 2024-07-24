require 'bundler/setup'
# require 'sequel'
# require 'dry-validation'

Bundler.require(:default, ENV['RACK_ENV'] || :development)

# ENV
require_relative 'load_env'
# Настройка подключения к базе данных
require_relative 'database'

# Метод для рекурсивного подключения всех файлов в директории
def require_all(directory)
  Dir.glob(File.join(directory, '**', '*.rb')).sort.each do |file|
    require file
  end
end

# Загрузка всех инициализаторов
require_all(File.expand_path('initializers', __FILE__))

%w[models controllers commands presenters].each do |directory|
  require_all(File.expand_path("../../app/#{directory}", __FILE__))
end
