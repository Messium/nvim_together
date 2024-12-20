# install lazyvim
if [ ! -d "$HOME/.config/nvim-lazyvim/" ]; then
  echo "No lazyvim installed proceeding to installation"
  git clone https://github.com/LazyVim/starter ~/.config/nvim-lazyvim/
fi

# plugin_dir
plugin_dir="$HOME/.config/nvim-lazyvim/lua/plugins/"
options_dir="$HOME/.config/nvim-lazyvim/lua/config/options.lua"

# live_share
live_share_plugin_path="$plugin_dir/live-share.lua"

# check if folder exist (should exist)
if [ ! -d "$plugin_dir" ]; then
  mkdir -p "$plugin_dir"
fi


if ! grep -q "$live_share" "$live_share_plugin_path"; then
    read user_name
    echo "$user_name"
    # setup liveshare.nvim config
    # https://github.com/azratul/live-share.nvim
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
fi
