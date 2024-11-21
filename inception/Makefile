
COMPOSE=docker compose

COMPOSE_FILE=./srcs/docker-compose.yml

NETWORK=inception

all : build up

re : down build up

up :
	$(COMPOSE) -f $(COMPOSE_FILE) up -d

down :
	$(COMPOSE) -f $(COMPOSE_FILE) down

stop :
	$(COMPOSE) -f $(COMPOSE_FILE) stop

start :
	$(COMPOSE) -f $(COMPOSE_FILE) start

build :
	$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache
	
logs :
	$(COMPOSE) -f $(COMPOSE_FILE) logs 

net :
	docker network inspect $(NETWORK)

clean :
	$(COMPOSE) -f $(COMPOSE_FILE) down -v
	docker system prune -a --volumes 

fclean : clean
	sudo rm -rf /home/chansjeo/data/mariadb/*
	sudo rm -rf /home/chansjeo/data/wordpress/*

volume : 
	mkdir -p /home/chansjeo/data/mariadb
	mkdir -p /home/chansjeo/data/wordpress

.PHONY: re up down build clean fclean logs net start stop volume
