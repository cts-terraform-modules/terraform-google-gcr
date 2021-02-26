#!/bin/bash

# Add these two lines to your .bashrc (customize appropriately)
#
#   export TVX_BASE_DIR=${HOME}/src/travelex-vscode
#   source TVX_BASE_DIR/.devcontainer/tvx-setup.sh
#
# Then
#
#   tvx bash - a working vscode like dev shell
#   tvx terragrunt plan - run terragrunt via the docker container
#   tvx tg plan
#   tvx kubectl...

# Basically all the commands available in the docker container are availabe
# to you nicely wrapped.  Using `tvx bash` is likey the most robust way.
# `tvx tg plan` does work also.

demo_help() {
    echo "You must set TVX_BASE_DIR"
    exit 1
}

demo() {
    
    [[ (-z ${DEMO_BASE_DIR}) ]] && demo_help


    REL_DOCKER_DIR=$(pwd | sed -e "s@$DEMO_BASE_DIR@/workspace/travelex-vscode@")

    case $1 in
        tg)
            SC=terragrunt
            ;;
        k)
            SC=kubectl
            ;;
        *)
            SC=$1
    esac
    shift 

    docker run \
           -it \
           --privileged \
           -w $REL_DOCKER_DIR \
           -u vscode \
           -v $SSH_AUTH_SOCK:/tmp/.ssh-auth-sock \
           -v $HOME/.config:/home/vscode/.config \
           -v $DEMO_BASE_DIR:/workspace/travelex-vscode/ \
           -v /var/run/docker.sock:/var/run/docker.sock \
           argocd-demo $SC $@
}
