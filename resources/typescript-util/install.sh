#!/bin/bash


#make directory for resources
if [ -d "resources" ]
then
    mkdir -p ~/.resources/@@PROJECT@@/
    cp resources ~/.resources/@@PROJECT@@/
fi

mkdir -p $HOME/bin
cp @@PROJECT@@ $HOME/bin
