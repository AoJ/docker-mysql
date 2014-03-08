# Project: mysql with docker.io
# Author: AoJ <aoj@n13.cz>
# Date: 2014
# usage:
#	make build	- build new image from Dockerfile
#	make debug	- debug run already created image and attach to it
#	make try	- build and run in debug mode
#	make remove	- discarding current running production container
#	make deploy	- build new, discard old and run new in production
#	make logs	- display docker logs for production

NAME=aooj/mysql
ID=mysql
VERSION=1.1


build:
	docker build -t $(NAME):$(VERSION) .


debug:
	docker run -entrypoint="/bin/bash" -p 3306 -t -i $(NAME):$(VERSION) -c /bin/bash

remove:
	docker kill $(ID) > /dev/null 2>&1
	docker rm $(ID) > /dev/null 2>&1

run:
	docker run -p 3306 -t -i -name $(ID) $(NAME):$(VERSION)

deploy: build remove run

production:
	docker run -d -i -t -p 3306:3306 -name $(ID) $(NAME):$(VERSION)

logs:
	docker logs $(ID)


try: build debug


.PHONY: build debug try run remove logs deploy

