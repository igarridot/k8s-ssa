tag_name = norbega/
golang_version := 1.18
VERSION ?= v0.1.0
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

install-deps:
	go mod init || true
	go mod tidy
