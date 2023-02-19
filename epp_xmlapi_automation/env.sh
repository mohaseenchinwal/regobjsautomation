#!/bin/sh

CP=$PWD/etc

for file in $(ls target/lib/*.jar)
do
	CP=$CP:$PWD/$file
done

for file in $(ls deps/lib/*.jar)
do
	CP=$CP:$PWD/$file
done

export CLASSPATH=$CP

