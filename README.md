# GoodNight

GoodNight is a social application designed to help you track and analyze your sleep.

## How to use

### First time to start the application

```shell
docker compose build
docker compose run web rake db:create
docker compose run web rake db:migrate
docker compose up
```
then you can see the service start successfully in port 3000, for the reason that may cause conflict with local development, so I change the port to 3001

open http://localhost:3001


