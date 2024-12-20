#!/bin/bash

read -p "Enter your username: " username
sed -i "s/^\s\+vim\.g\.instant_username.*/      vim.g.instant_username = \"$username\"/" /home/vagrant/.config/nvim/lua/plugins/live-share.lua
