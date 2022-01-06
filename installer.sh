#!/bin/bash

chmod +x ~/git-commit-template/template.sh
echo alias gct=~/git-commit-template/template.sh >~/git-commit-template/zsh_gct
echo source ~/git-commit-template/zsh_gct >>.zshrc
