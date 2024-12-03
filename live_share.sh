#!bin/bash

config_path="$HOME/.config/nvim/lua/plugins/live-share.lua"
# mkdir -p "$config_path"

read user_name
echo $user_name

live_share="""
return {
  -- add symbols-outline
  {
    "azratul/live-share.nvim",
    dependencies = {
      "jbyuki/instant.nvim",
    },
    config = function()
      vim.g.instant_username = \"$user_name\"
      require("live-share").setup({
        port_internal = 8765,
        max_attempts = 40, -- 10 seconds
        service = "serveo.net",
      })
    end,
  },
}
"""
echo $live_share >>$config_path
