
COMPOSE=docker compose

COMPOSE_FILE=./srcs/docker-compose.yml

CONTAINERS=$(shell docker ps -a -q)
IMAGES=$(shell docker images -q)

up :
	$(COMPOSE) -f $(COMPOSE_FILE) up -d

down :
	$(COMPOSE) -f $(COMPOSE_FILE) down -v

build :
	$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache

clean :
	docker stop $(CONTAINERS)
	docker rm $(CONTAINERS)
	docker rmi $(IMAGES)
	docker system prune -a --volumes 

.PHONY: up down
