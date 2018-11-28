NAME = anchorfree/fluentd
VERSION = v5.0.0

.PHONY: all

all: build latest release

build:
	docker build -t $(NAME):$(VERSION) --rm .

latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

release:
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME):$(VERSION)
	docker push $(NAME):latest
	@echo "*** Don't forget to assign production tag as soon as you feel it is ready: make prod"

prod:
	docker tag $(NAME):$(VERSION) $(NAME):prod
	docker push $(NAME):prod
	docker rmi $(NAME):prod
