#!bin/bash


zshrc_path="$HOME/.zshrc"
bashrc_path="$HOME/.bashrc"

# Install zoxide, zsh and fzf
if command -v apt >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y zoxide zsh fzf
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y zoxide zsh fzf
else
  echo "Neither apt nor dnf found. Please install zoxide and zsh manually."
fi

if [ ! -f ~/.atuin/bin ]; then
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    echo "eval \"$(atuin init zsh)\"" >> "$zshrc_path"
    echo 'eval \"$(atuin init bash)\"' >> "$bashrc_path"
fi

# install starship
if [ ! -f /usr/bin/starship ]; then
  # install starship
  curl -sS https://starship.rs/install.sh | sh
  # ~/.zshrc
  echo "eval \"$(starship init zsh)\"" >> "$zshrc_path"
  # ~/.bashrc
  echo "eval \"$(starship init bash)\"" >> "$bashrc_path"
fi

# lazyvim installed?
if [ ! -d "$HOME/.config/nvim-lazyvim/" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim-lazyvim/
fi

# plugin_dir
plugin_dir="$HOME/.config/nvim-lazyvim/lua/plugins/"

# live_share
live_share_plugin_path="$plugin_dir/live-share.lua"
avante_ai_plugin_path="$plugin_dir/avante.lua"

if [ ! -d "$plugin_dir" ]; then
  mkdir -p "$plugin_dir"
fi

read user_name
echo $user_name

live_share="""return {
  {
    \"azratul/live-share.nvim\",
    dependencies = {
      \"jbyuki/instant.nvim\",
    },
    config = function()
      vim.g.instant_username = \"$user_name\"
      require(\"live-share\").setup({
        port_internal = 8765,
        max_attempts = 40, -- 10 seconds
        service = \"serveo.net\",
      })
    end,
  },
}"""
echo "$live_share" >"$live_share_plugin_path"

avante_ai="""return {
    \"yetone/avante.nvim\",
    event = \"VeryLazy\",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    config = function()
        require(\"plugins.avante\")
    end,
    opts = {
        mappings = {
            -- ask = \"<leader>ua\", -- ask
            -- edit = \"<leader>ue\", -- edit
            -- refresh = \"<leader>ur\", -- refresh
            suggestion = {
                accept = \"<C-c>\",
            },
        },
        -- },
        -- add any opts here
    },
}"""
echo "$avante_ai" >"$avante_ai_plugin_path"
# echo "require(\"telescope\").load_extension(\'zoxide\')" >> $plugin_dir/telescope.lua


if ! grep -q "alias lazy='NVIM_APPNAME=nvim-lazyvim nvim' # LazyVim" "$HOME/.bashrc"; then
  echo "alias lazy='NVIM_APPNAME=nvim-lazyvim nvim' # LazyVim" >>"$HOME/.bashrc"
  source "$HOME/.bashrc"
fi
lazy
