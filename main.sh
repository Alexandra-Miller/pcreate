#!/bin/bash


# ====================  CONSTANTS  =============================================

HELPMSG="USAGE: pcreate PROJECT_NAME PROJECT_TYPE
PROJECT TYPES:
c
c++
o   other
h   haskell
t   typescript
b   bash                linux utility written in bash with install script
cu  c-utility           linux utility written in c with install script
tu  typescript-utility  linux utility written in typescript with install script
"

GITIGNORE="https://gist.githubusercontent.com/Alexandra-Miller/b47139749f861f02d3176f57f17626ce/raw/160e75b70f51c2c5ef5201735f0d457abadf829d/.gitignore"

STANDARD_HEADER="
@project: $1
@repo: https://github.com/Alexandra-Miller/$1
@creator: Alexandra Marie Miller
@description

@description
@deps: 
"

RESOURCES_DIR="$HOME/.resources/pcreate/resources"
[ -d "resources" ] && RESOURCES_DIR="resources"


# ====================  FUNCTIONS  =============================================

# $1 = project name
createGit () {
    ( 
    cd $1
    git init
    echo "# $1" >> README.md
    curl $GITIGNORE -o .gitignore
    git add .
    git commit -m "Initial commit"
    )
}

# $1 = project name
configMake () {
    sed -i "s/@@PROJECT@@/$1/g" $1/makefile
}

# $1 = project name
configInstall () {
    sed -i "s/@@PROJECT@@/$1/g" $1/install.sh
}

# $1 = project name     $2 = main filename
configFile () {
    sed -i "s/@@PROJECT@@/$1/g" $1/$2
}

# $1 = project name
createC () {
    cp $RESOURCES_DIR/c/* $1/
    configMake $1
    configFile $1 main.c
}

# $1 = project name
createCpp () {
    cp $RESOURCES_DIR/c++/* $1/
    configMake $1
    configFile $1 main.cpp
}

# $1 = project name
createElixir () {
    cp $RESOURCES_DIR/elixir/* $1/
    configMake $1
    configFile $1 main.ex
}

# $1 = project name
createHaskell () {
    cp $RESOURCES_DIR/haskell/* $1/
    configMake$1
    configFile $1 main.hs
}

# $1 = project name
createOther () {
    cp $RESOURCES_DIR/other/* $1/
}

# $1 = project name
createTypescript () {
    ( 
    cd $1
    npm init
    npm install 
    )
    cp $RESOURCES_DIR/typescript/* $1/
    configMake $1
    configFile $1 index.ts
}

# $1 = project name
createBash () {
    cp $RESOURCES_DIR/bash/
    configMake $1
    configInstall $1
    configFile $1 main.sh
}

# $1 = project name
createCUtil () {
    cp $RESOURCES_DIR/c-util/* $1/
    configMake $1
    configInstall $1
    configFile $1 main.c
}

# $1 = project name
createTypescriptUtil () {
    ( 
    cd $1
    npm init
    npm install 
    )
    cp $RESOURCES_DIR/typescript-util/* $1/
    configMake $1
    configInstall $1
    configFile $1 index.ts
}


if [ $# -eq 1  ]
then
    mkdir $1
    createOther $1
    createGit $1

elif [ $# -eq 2 ]
then
    mkdir $1

    [ $2 = "c" ] && createC $1

    [ $2 = "c++" ] && createCpp $1
    
    [ $2 = "elixir" ] || [ $2 = "e" ] && createElixir $1
    
    [ $2 = "haskell" ] || [ $2 = "h" ] && createHaskell $1

    [ $2 = "other" ] || [ $2 = "o" ] && createOther $1
    
    [ $2 = "typescript" ] || [ $2 = "t" ] && createTypescript $1

    [ $2 = "bash" ] || [ $2 = "b" ] && createBash $1
    
    [ $2 = "c" ] && createC $1
    
    [ $2 = "typescript-util" ] || [ $2 = "tu" ] && createTypescriptUtil $1
    

    createGit $1
else
    echo "$HELPMSG"

fi
