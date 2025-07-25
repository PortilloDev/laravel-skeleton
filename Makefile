api_port := 8080

start:
	@docker-compose -f docker-compose.yml up -d
	@echo 'App api started at:  http://localhost:$(api_port)'

deploy:
	@docker-compose run app bin/deploy.sh

console:
	@docker-compose exec app bash

stop:
	@docker-compose stop

destroy: stop
	@docker-compose down --rmi all