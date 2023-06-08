#!/bin/bash

docker run \
    --rm \
    --interactive \
    --tty \
    --mount type=bind,source="$(pwd)",target=/usr/src/app \
    --publish 3000:3000 \
    --user $(id -u):$(id -g) \
    appunti_sweng \
    serve --hostname 0.0.0.0 --port 3000
