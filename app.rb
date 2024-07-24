require 'sinatra'
require './config/environment'

# Запуск приложения
class SecureAuthApp < Sinatra::Base
  use UsersController

  run! if app_file == $0
end