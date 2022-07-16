FROM alpine

RUN apk --no-cache add bash

RUN mkdir -p /p6m7g8/p6common

WORKDIR /p6m7g8/p6common

COPY . .

RUN bin/p6ctl docker_build

ENV TERM xterm-256color
RUN bin/p6ctl docker_test
