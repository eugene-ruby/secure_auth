require 'sneakers'
require 'json'

class UserWorker
  include Sneakers::Worker

  # Указываем имя очереди, из которой будем получать сообщения
  from_queue 'users_queue'

  # Метод для обработки сообщений
  def work(message)
    data = JSON.parse(message)
    puts "Received message: #{data['message']}"

    # Подтверждаем, что сообщение обработано
    ack!
  end
end
