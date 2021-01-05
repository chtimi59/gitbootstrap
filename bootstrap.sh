#!/bin/bash
set -e

if [ -z $1 ]; then
    echo "usage: $0 <repo_name> [ssh_keypath]" > /dev/stderr
    exit 1
fi

GIT_REPO_NAME=$1
GIT_REPO_URL=git@github.com:chtimi59/$GIT_REPO_NAME.git
GIT_FOLDER=/opt/$GIT_REPO_NAME
GIT_SSHKEY=$2

if [ ! -z $GIT_SSHKEY ]; then
    GIT_SSH_COMMAND="ssh -i $GIT_SSHKEY -o IdentitiesOnly=yes"
fi

# need git, at least
which git 1>/dev/null || sudo apt install git

# git clone
if [ -e $GIT_FOLDER ]; then
    echo "warning: already installed, try updating"
    cd $GIT_FOLDER 
    if [ ! -z $GIT_SSHKEY ]; then
        sudo GIT_SSH_COMMAND="$GIT_SSH_COMMAND" git pull
    else
        sudo git pull
    fi
else
    if [ ! -z $GIT_SSHKEY ]; then
        sudo GIT_SSH_COMMAND="$GIT_SSH_COMMAND" git clone $GIT_REPO_URL $GIT_FOLDER
    else
        git clone $GIT_REPO_URL $GIT_FOLDER
    fi
fi

# add a link to used private key
if [ ! -z $GIT_SSHKEY ]; then
    sudo mkdir -p $GIT_FOLDER/.ssh/
    sudo chmod u+xr,go-rwx $GIT_FOLDER/.ssh
    sudo ln -f -s $GIT_SSHKEY $GIT_FOLDER/.ssh/github
fi

# shortcut
echo ""
echo "output folder: $GIT_FOLDER"
