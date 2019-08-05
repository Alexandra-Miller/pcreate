#!/bin/bash


#make directory for resources
if [ -d "resources" ]
then
    mkdir -p ~/.resources/@@PROJECT@@/
    cp -r resources ~/.resources/@@PROJECT@@/
fi

mkdir -p $HOME/bin
cp main.sh $HOME/bin/@@PROJECT@@
