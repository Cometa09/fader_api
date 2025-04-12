# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Можно заменить '*' на конкретный домен (например, 'http://94.19.108.52'), чтобы ограничить доступ только с определенного источника.

    resource '*',
      headers: :any,
      methods: [:get, :post, :patch, :put, :delete, :options],
      expose: ['Authorization']  # Если требуется, можно добавить заголовки для ответа.
  end
end
