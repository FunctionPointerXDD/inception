
COMPOSE=docker compose

COMPOSE_FILE=./srcs/docker-compose.yml

up :
	$(COMPOSE) -f $(COMPOSE_FILE) up -d

down :
	$(COMPOSE) -f $(COMPOSE_FILE) down

build :
	$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache
	
log:
	$(COMPOSE) -f $(COMPOSE_FILE) logs 

clean :
	$(COMPOSE) -f $(COMPOSE_FILE) down -v
	docker system prune -a --volumes 

.PHONY: up down build clean log
