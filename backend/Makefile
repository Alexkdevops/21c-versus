export AWS_REGION = "us-east-1"
stage = ${STAGE}
include stages/$(stage)

account = $(shell aws sts get-caller-identity --query "Account" --output text)
repo = versus-backend
artifact = $(account).dkr.ecr.us-east-1.amazonaws.com/$(repo):$(version)

build:
	@docker build -t $(artifact) .

test:
	@docker run -d --env-file ./.env.test -e MYSQL_USER=$(MYSQL_USER) -e MYSQL_PASSWORD=$(MYSQL_PASSWORD) --name backend $(artifact)
	@docker exec -t backend python manage.py test
	@docker rm -f backend

login:
	@aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(account).dkr.ecr.us-east-1.amazonaws.com

push: login 
	@docker push $(artifact)

deploy:
	cat kubernetes/backend-deployment.yaml | sed "s/VERSION/$(version)/g;s/ACCOUNT/$(account)/g;s/NAMESPACE/$(namespace)/g;s/MYSQL_USER_VALUE/$(MYSQL_USER)/g;s/MYSQL_PASSWORD_VALUE/$(MYSQL_PASSWORD)/g" | kubectl apply -f -
	cat kubernetes/backend-service.yaml | sed "s/NAMESPACE/$(namespace)/g" | kubectl apply -f -
