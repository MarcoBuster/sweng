#!/bin/bash

docker run \
    --rm \
    --interactive \
    --mount type=bind,source="$(pwd)",target=/usr/src/app \
    --publish 3000:3000 \
    --user $(id -u):$(id -g) \
    ghcr.io/marcobuster/sweng \
    serve --hostname 0.0.0.0 --port 3000
