# add phony so make build refers to the build command rather than the ./build folder
.PHONY: build

export AWS_REGION = $(reg)
acct = $(shell aws sts get-caller-identity --query "Account" --output text)
image = $(acct).dkr.ecr.$(reg).amazonaws.com/$(repo):$(ver)
stage = ${STAGE}
include stages/$(stage)


build:
	@docker build -t $(image) .


push:
	@aws ecr get-login-password --region $(reg) | docker login --username AWS --password-stdin $(acct).dkr.ecr.$(reg).amazonaws.com
	@docker push $(image)

deploy:
	@cat kubernetes/frontend-deploy.yaml | sed "s|VER|$(ver)|g; s|ACCT|$(acct)|g; s|NAMESPACE|$(namespace)|g; s|REG|$(reg)|g; s|REPO|$(repo)|g" | kubectl apply -f -
	@cat kubernetes/frontend-svc.yaml | sed "s|NAMESPACE|$(namespace)|g" | kubectl apply -f -
