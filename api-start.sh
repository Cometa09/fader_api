# api-start.sh
#!/bin/bash

# Перейдите в каталог вашего проекта Rails
cd /rails/fader-api

# Запустите сервер Rails в фоновом режиме
rails server -b 0.0.0.0 -p 3000 -e production &
