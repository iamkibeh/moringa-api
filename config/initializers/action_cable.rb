Rails.application.config.action_cable.disable_request_forgery_protection = true

Rails.application.config.action_cable.allowed_request_origins = ['http://localhost:3000', 'http://localhost:3001']

Rails.application.config.action_cable.url = "ws://localhost:5000/cable"

Redis.current = Redis.new(url: ENV['REDIS_URL']) || 'redis://localhost:6379/1'
