
COMPOSE=docker compose

COMPOSE_FILE=./srcs/docker-compose.yml

all : hosts build up

# hosts : 
# 	sudo sed -i 's/localhost/chansjeo.42.fr/g' /etc/hosts	

up :
	$(COMPOSE) -f $(COMPOSE_FILE) up -d

down :
	$(COMPOSE) -f $(COMPOSE_FILE) down

build :
	$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache
	
logs:
	$(COMPOSE) -f $(COMPOSE_FILE) logs 

clean :
	$(COMPOSE) -f $(COMPOSE_FILE) down -v
	docker system prune -a --volumes 

.PHONY: up down build clean log hosts
