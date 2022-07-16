FROM alpine

RUN apk --no-cache add bash

RUN mkdir -p /p6m7g8/p6common

WORKDIR /p6m7g8/p6common

COPY . .

RUN apk --no-cache add git

ENV DOCKER_WORKFLOW Build
RUN bin/deps.sh

RUN bin/p6ctl docker_build

ENV TERM xterm-256color
RUN bin/p6ctl docker_test