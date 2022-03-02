# add phony so make build refers to the build command rather than the ./build folder
.PHONY: build

export AWS_REGION = "us-east-1"
stage = ${STAGE}
include stages/$(stage)

account = $(shell aws sts get-caller-identity --query "Account" --output text)
repo = versus-frontend
artifact = $(account).dkr.ecr.us-east-1.amazonaws.com/$(repo):$(version)

test:
	yarn test --watchAll=false --coverage --silent

build:
	yarn
	yarn build
	docker build -t $(artifact) .

login:
	@aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(account).dkr.ecr.us-east-1.amazonaws.com

push: login
	@docker push $(artifact)

deploy:
	cat kubernetes/frontend-deployment.yaml | sed "s/VERSION/$(version)/g;s/ACCOUNT/$(account)/g;s/NAMESPACE/$(namespace)/g" | kubectl apply -f -
	cat kubernetes/frontend-service.yaml | sed "s/NAMESPACE/$(namespace)/g" | kubectl apply -f -
