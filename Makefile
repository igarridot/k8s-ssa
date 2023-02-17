tag_name = norbega/
golang_version := 1.18
VERSION ?= v0.1.10
PROJECT ?= k8s-ssa

build:
	@docker build -t $(tag_name)$(PROJECT):$(VERSION) -f Dockerfile \
		--build-arg GOLANG_VERSION=$(golang_version) \
		--build-arg PROJECT_NAME=$(PROJECT) \
		.

push:
	docker push $(tag_name)$(PROJECT):$(VERSION)
authorize:
	gcloud docker --authorize-only

delete:
	kubectl delete -f app.yml

apply:
	kubectl apply -f app.yml

all: build push delete apply

install-deps:
	go mod init || true
	go mod tidy
