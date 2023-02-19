#!/bin/sh

CLASSPATH=uat.jar:arjtk.jar:etc:. java -Djava.util.logging.config.file=$PWD/etc/logging.properties "$@"

