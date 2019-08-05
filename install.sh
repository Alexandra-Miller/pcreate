#!/bin/bash


#make directory for resources
if [ -d "resources" ]
then
    mkdir -p ~/.resources/pcreate/
    cp -r resources ~/.resources/pcreate/
fi

mkdir -p $HOME/bin
cp main.sh $HOME/bin/pcreate
