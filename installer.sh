#!/bin/bash

chmod +x ~/git-commit-template/commit-template.sh
echo alias gct=~/git-commit-template/commit-template.sh >~/git-commit-template/zsh_gct
echo alias gtt=~/git-commit-template/tag-template.sh >>~/git-commit-template/zsh_gct
echo source ~/git-commit-template/zsh_gct >>.zshrc
