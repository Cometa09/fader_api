# api-stop.sh
#!/bin/bash

# Найдите процесс сервера Rails и остановите его
kill $(lsof -t -i:3000)
