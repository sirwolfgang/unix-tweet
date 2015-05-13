#!/bin/bash

export POSTGRES_URL=postgres://postgres:@$(boot2docker ip 2>/dev/null):5432/unix

docker run -d -p 5432:5432 -e "POSTGRES_NAME=unix" -e "POSTGRES_NAME=unix" -e "POSTGRES_USER=postgres"  -e "POSTGRES_PASS=" postgres:9.3
