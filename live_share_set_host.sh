#!/bin/bash

read -p "Enter either serveo.net or localhost.run: " service

sed -i "/service = ".*"/s/service = ".*"/service = \"$service\",/" live-share.lua
