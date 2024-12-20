#!/bin/bash

# 1. copy lua file to lua plugins folder
cp live-share.lua /home/vagrant/.config/nvim/lua/plugins/live-share.lua
echo "live-share.lua copied to lua folder"
# 2. run username prompt to set username for live-share nvim.
echo "running username prompt for nvim live share"
source ./live_share_set_user.sh
echo "Success"
