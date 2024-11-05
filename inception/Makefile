
COMPOSE=docker compose

COMPOSE_FILE=./srcs/docker-compose.yml

up :
	$(COMPOSE) -f $(COMPOSE_FILE) up -d

down :
	$(COMPOSE) down

clean :
	docker stop `docker ps -a -q`
	docker rm `docker ps -a -q`
	docker rmi `docker images -q`
	docker system prune -a --volumes

.PHONY: up down