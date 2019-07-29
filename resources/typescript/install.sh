#!/bin/bash


#make directory for resources
if [ -d "resources" ]
then
    mkdir -p ~/.resources/@@PROJECT@@/
    mv resources ~/.resources/@@PROJECT@@/
fi

mkdir -p $HOME/bin
mv @@PROJECT@@ $HOME/bin
