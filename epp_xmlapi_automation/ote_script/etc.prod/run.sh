#!/bin/sh

java -Djava.util.logging.config.file=$PWD/etc/logging.properties "$@"

