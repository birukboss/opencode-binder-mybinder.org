#!/usr/bin/env bash

# Ensure OpenCode is in PATH
export PATH="$HOME/.opencode/bin:$PATH"

# Example startup commands (customize as needed):
# git config --global user.name "Your Name"
# git config --global user.email "you@example.com"
# cd ~/work

# Install OpenCode
curl -fsSL https://opencode.ai/v2/install | bash

# Launch OpenCode
# opencode

# Remote access launched
opencode pair --remote --yes 
