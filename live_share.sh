#!bin/bash

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
