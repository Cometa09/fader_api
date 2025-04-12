# config/initializers/reset_redis_cache.rb

Rails.application.config.after_initialize do
  # Сбрасываем все данные из Redis при старте приложения
  $redis.flushall
  Rails.logger.info "Redis cache has been cleared"
end
puts "Reset redis cache... OK"