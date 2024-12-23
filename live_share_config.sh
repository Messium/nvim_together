#!/bin/bash

echo "hello what do you want to do?"

set_host() {
    ./live_share_set_host.sh
}

set_user() {
    ./live_share_set_user.sh
}

set_host
set_user
