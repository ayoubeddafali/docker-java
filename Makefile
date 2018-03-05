.PHONY: test package deploy clean

clr = \033[1;33m
restore = \033[0m

init:
	@echo "$(clr) Running Init Playbook $(restore)"
	#ansible-playbook init.yml

test:
	@echo "$(clr)Building Images & Running Units/Functional Tests$(restore)"
	docker-compose -f docker/dev/docker-compose-test.yml build
	docker-compose -f docker/dev/docker-compose-test.yml up
	@echo "$(clr) Test Finished $(restore)"

build:
	@echo "$(clr)Packaging$(restore)"
	docker-compose -f docker/dev/docker-compose.yml build
	docker-compose -f docker/dev/docker-compose.yml up

deploy:
	@echo "$(clr) Deploy to NEXUS $(restore)"
	docker-compose -f docker/dev/docker-compose-deploy.yml build
	docker-compose -f docker/dev/docker-compose-deploy.yml up

release:
	@echo "$(clr)Building release images & running environment $(restore)"
	docker-compose -f docker/release/docker-compose.yml build

publish:
	@echo "$(clr)Publishing release images to dockerhub $(restore)"

functional_test:
	@echo "$(clr)Running Functional Tests $(restore)"
	@docker-compose -f docker/functional-tests/docker-compose.yml build
	@docker-compose -f docker/functional-tests/docker-compose.yml up
	@echo "$(clr)Functional Tests DONE $(restore)"

performance_test:
	@echo "$(clr)Running Performance Tests $(restore)"
	@docker-compose -f docker/performance-tests/docker-compose.yml build
	@docker-compose -f docker/performance-tests/docker-compose.yml up
	@echo "$(clr)Performance Tests DONE $(restore)"

clean:
	@echo "$(clr)Cleaning Containers / Networks & dangling images  $(restore)"
	@docker images -q -f dangling=true | xargs -I docker rmi
	@docker ps -a -q  | xargs -I docker rm -f
	docker-compose -f docker/dev/docker-compose-test.yml down
	docker-compose -f docker/dev/docker-compose.yml down
	docker-compose -f docker/dev/docker-compose-deploy.yml down
	@echo "$(clr) Cleaning DONE !! $(restore)"



