## environment

- Docker
- Ruby 2.7.5
- Ruby on Rails 6.1.6
- Mysql 8.0

## config
```
$ git config --global core.autocrlf false
```
## clone project
```bash
$ git clone https://github.com/waizinhtunscm/crud.git
```
## development preparation

```bash
# env file
$ cp .env.example .env

# Docker Image
$ docker-compose build

# start the app  with bash
$ docker-compose run --rm app bash

# Node module installation
$ bin/yarn install

$ rails db:migrate

# stop app bash
$ exit

# start app
$ docker-compose up -d
```
`http://localhost:8090`



