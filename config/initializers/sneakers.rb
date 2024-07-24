require 'sneakers'

Sneakers.configure(
  amqp: ENV['RABBIT_MQ_AMQP'],
  vhost: '/',
  timeout_job_after: 30, # время ожидания перед таймаутом работы
  exchange_type: :direct
)