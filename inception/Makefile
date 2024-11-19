
COMPOSE=docker compose

COMPOSE_FILE=./srcs/docker-compose.yml

NETWORK=inception

# hosts : 
# 	sudo sed -i 's/localhost/chansjeo.42.fr/g' /etc/hosts	

all : hosts build up

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

.PHONY: up down build clean logs hosts net start stop re
