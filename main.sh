#!/bin/bash

: '
@filename: scheduler
  @repository: https://github.com/Alexandra-Miller/scheduler
  @creator: Alexandra Marie Miller
  @description
A simple script to create and configure basic install scripts in new projects.
USAGE: pcreate PROJECT_NAME OPTIONS
OPTIONS:
-c                      standard program in c
-c++                    standard program in C++
-e      --elixir        standard program in elixir
-o      --other         standard program with no specified language
-h      --haskell       standard program in haskell
-t      --typescript    standard program written in typescript
-b      --bash                  utility written in bash with install script
-cu     --c-utility             utility written in c with install script
-tu     --typescript-utility    utility written in typescript with install script
  @description
  @dependancies: bash, git
'

# ====================  CONSTANTS  =============================================

HELPMSG="USAGE: pcreate PROJECT_NAME OPTIONS
OPTIONS:
-c                      standard program in c
-c++                    standard program in C++
-e      --elixir        standard program in elixir
-o      --other         standard program with no specified language
-h      --haskell       standard program in haskell
-t      --typescript    standard program written in typescript
-b      --bash                  utility written in bash with install script
-cu     --c-utility             utility written in c with install script
-tu     --typescript-utility    utility written in typescript with install script
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

RESOURCES_DIR="$HOME/.resources/pcreate/"
[ -d "resources" ] && RESOURCES_DIR="resources"


# ====================  FUNCTIONS  =============================================

# $1 = project name
createGit () {
    ( 
    cd $1

    # create git repo
    git init
    curl $GITIGNORE -o .gitignore
    
    # create README.md
    echo "# $1" >> README.md
    read -p "Enter Project Description:" descText
    echo "$descText" >> README.md
    
    # add git files and commit
    git add .
    git commit -m "Initial commit"
    )
}

# $1 = project name
configMake () {
    sed -i "s/@@PROJECT@@/$1/g" $1/makefile
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
    cp $RESOURCES_DIR/bash/* $1/
    configMake $1
    configFile $1 main.sh
}

# $1 = project name
createCUtil () {
    cp $RESOURCES_DIR/c-util/* $1/
    configMake $1
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

    [ $2 = "-c" ] && createC $1

    [ $2 = "-c++" ] && createCpp $1
    
    [ $2 = "--elixir" ] || [ $2 = "-e" ] && createElixir $1
    
    [ $2 = "--haskell" ] || [ $2 = "-h" ] && createHaskell $1

    [ $2 = "--other" ] || [ $2 = "-o" ] && createOther $1
    
    [ $2 = "--typescript" ] || [ $2 = "-t" ] && createTypescript $1

    [ $2 = "--bash" ] || [ $2 = "-b" ] && createBash $1
    
    [ $2 = "--c-util" ] || [ $2 = "-c" ] && createC $1
    
    [ $2 = "--typescript-util" ] || [ $2 = "-tu" ] && createTypescriptUtil $1
    

    createGit $1
else
    echo "$HELPMSG"

fi

