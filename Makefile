
DOCKER_COMPOSE := docker-compose -f srcs/docker-compose.yml

# define standard colors
_END			:=	\033[0m
_BOLD			:=	\033[1m
_UNDER			:=	\033[4m
_REV			:=	\033[7m
_GREY			:=	\033[30m
_RED			:=	\033[31m
_GREEN			:=	\033[32m
_YELLOW			:=	\033[33m
_BLUE			:=	\033[34m
_PURPLE			:=	\033[35m
_CYAN			:=	\033[36m
_WHITE			:=	\033[37m

all: up

up:
	@echo "$(_GREEN) Rebuild and start all the containers in detached mode$(_END)"
	${DOCKER_COMPOSE} up -d --build

build:
	@echo "$(_GREEN)Build images$(_END)"
	$(DOCKER_COMPOSE) build

start:
	@echo "$(_GREEN)Start containers$(_END)"
	$(DOCKER_COMPOSE) start

restart:
	@echo "$(_GREEN)Restart containers$(_END)"
	$(DOCKER_COMPOSE) restart

stop:
	@echo "$(_GREEN)Stop containers$(_END)"
	$(DOCKER_COMPOSE) stop

down:
	@echo "$(_GREEN)Stop and remove containers, volumes and networks$(_END)"
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans

ps:
	@echo "$(_GREEN)List running containers$(_END)"
	$(DOCKER_COMPOSE) ps

images:
	@echo "$(_GREEN)List images$(_END)"
	docker images

volume:
	@echo "$(_GREEN)List volumes$(_END)"
	docker volume ls

clean: down

fclean: clean
	@echo "$(_GREEN)Removes images, containers and volumes$(_END)"
	sudo rm -rf /home/$(USER)/data/wordpress/*
	sudo rm -rf /home/$(USER)/data/mariadb/*

prune: fclean
	@echo "$(_GREEN)Removes all unused images, containers and volumes$(_END)"
	sudo docker system prune -f -a

re: fclean all

.PHONY: all build start restart stop down ps images volume clean fclean prune re