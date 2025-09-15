#!/bin/bash

# Git config
sudo ./generate_github_ssh_key.sh

# Java config
sudo ./install_java17.sh

# Maven and Zsh sinstall
sudo apt install -y maven zsh

# Oh My Zsh install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
