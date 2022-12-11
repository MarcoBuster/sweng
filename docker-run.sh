#!/bin/bash

docker run \
    --rm \
    --interactive \
    --tty \
    --mount type=bind,source="$(pwd)",target=/usr/src/app \
    --publish 4000:4000 \
    --publish 35729:35729 \
    --user $(id -u):$(id -g) \
    appunti_sweng \
    --livereload 
