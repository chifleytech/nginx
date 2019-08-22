docker stop chifleytech_temp
docker rm chifleytech_temp
docker build . -t chifleytech/temp
docker run --name chifleytech_temp -d -p 8090:80 chifleytech/temp
docker exec -it chifleytech_temp /bin/bash
date