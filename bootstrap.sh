#!/bin/bash
set -e

if [ -z $1 ]; then
    echo "usage: $0 <repo_name> [ssh_keypath]" > /dev/stderr
    exit 1
fi

GIT_REPO_NAME=$1
GIT_SSHKEY=$2

GIT_REPO_URL=git@github.com:chtimi59/$GIT_REPO_NAME.git
GIT_FOLDER=/opt/$GIT_REPO_NAME

if [ -e $GIT_FOLDER ]; then
    echo "$GIT_FOLDER already exists"
    exit 0
fi

# need git, at least!
which git 1>/dev/null || (
    set +e
    sudo apt install git
    set -e
)

# actual git clone
if [ ! -z $GIT_SSHKEY ]; then
    sudo GIT_SSH_COMMAND="ssh -i $GIT_SSHKEY -o IdentitiesOnly=yes" git clone $GIT_REPO_URL $GIT_FOLDER
    
    # add a symlink to used private key
    sudo mkdir -p $GIT_FOLDER/.ssh/
    sudo chmod u+xr,go-rwx $GIT_FOLDER/.ssh # give it some privacy
    sudo ln -f -s $GIT_SSHKEY $GIT_FOLDER/.ssh/github

else
    sudo git clone $GIT_REPO_URL $GIT_FOLDER
fi

# shortcut
echo ""
echo "output folder: $GIT_FOLDER"
