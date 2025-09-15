#!/bin/bash

sudo ./generate_github_ssh_key.sh

sudo ./install_java17.sh

sudo apt install -y maven zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
