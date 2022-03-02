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
	@cat kubernetes/backend-deploy.yaml | sed "s|VER/$(ver)|g;s|ACCT|$(acct)|g;s|NAMESPACE|$(namespace)|g;s|MYSQL_USER_VALUE|$(MYSQL_USER)|g;s|MYSQL_PASSWORD_VALUE|$(MYSQL_PASSWORD)|g;s|REG|$(reg)|g;s|REPO|$(repo)|g" | kubectl apply -f -
service:	
	@cat kubernetes/backend-svc.yaml | sed "s/NAMESPACE/$(namespace)/g" | kubectl apply -f -
