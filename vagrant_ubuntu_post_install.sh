#!/bin/bash

# 1. install starship
echo "installing starship shell"
curl -sS https://starship.rs/install.sh | sh
echo "eval \"\$(starship init bash)"\" >> "$HOME/.bashrc"

# 2. install atuin
echo "installing atuin"
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
echo 'eval "$(atuin init bash)"' >> "$HOME/.bashrc"

# 3. install zoxide
echo "installing zoxide to .bashrc"
echo 'eval "$(zoxide init bash)"' >> "$HOME/.bashrc"

echo "Success"
