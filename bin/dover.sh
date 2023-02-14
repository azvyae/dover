#!/bin/bash
#
# Dover performs interactive command-line
# to interact with DigitalOcean through doctl commands

DROPLET_TARGET=''

#######################################
# Display version
#######################################
display_version() {
    echo "Dover 0.1.0"
    echo "MIT LICENSE Copyright © 2023 Azvya Erstevan I <erstevn@gmail.com>"
}

#######################################
# Show Dover logo
#######################################
show_logo() {
    echo "    ____                      "
    echo "   / __ \____ _   _____  _____"
    echo "  / / / / __ \ | / / _ \/ ___/"
    echo " / /_/ / /_/ / |/ /  __/ /    "
    echo "/_____/\____/|___/\___/_/     "
}

#######################################
# Show interactive shell main menu.
#######################################
show_main_menu() {
    if [ ! -z $DROPLET_TARGET ]; then
        CURRENT_TARGET=$DROPLET_TARGET
    else
        CURRENT_TARGET="none"
    fi
    echo
    echo "Current target: $CURRENT_TARGET"
    echo "Menu:"
    echo "1. Set's current session Droplet target"
    echo "2. Show available droplet sizes"
    echo "3. Resize current droplet"
    echo "0. Exit"
}

#######################################
# Choose main menu options.
# Arguments:
#   Numbers, to execute based on input
#######################################
choose_main_menu() {
    case $1 in
    1)
        set_current_target
        ;;
    2)
        show_droplet_sizes
        ;;
    3)
        resize_current_droplet
        ;;
    0)
        echo "Dover out, bye."
        exit
        ;;
    *)
        err "Option is invalid"
        ;;
    esac
}

#######################################
# Launch interactive Dover shell.
# Arguments:
#   String to be outputted
#######################################
start_interactive_shell() {
    local choice
    clear
    show_logo
    display_version
    while true; do
        show_main_menu
        read -p "Choose menu: " choice
        choose_main_menu $choice
        unset choice
    done
}

#######################################
# Check current Droplet target
#######################################
check_current_target() {
    if [ -z $DROPLET_TARGET ]; then
        set_current_target
    fi
}

#######################################
# Show droplet sizes
#######################################
show_droplet_sizes() {
    local QUERY
    check_current_target
    read -p "Search sizes (optional): " QUERY
    if [ -z "$QUERY" ]; then
        doctl compute size ls --format Slug,Description,PriceMonthly
    else
        doctl compute size ls --format Slug,Description,PriceMonthly | grep $QUERY
    fi
}

#######################################
# Resize current droplet
#######################################
resize_current_droplet() {
    local SIZE
    check_current_target
    while [[ -z "$SIZE" || ! $(doctl compute size ls --format Slug | grep -x $SIZE) ]]; do
        read -p "Set size: " SIZE
    done
    echo "Shutting down Droplet"
    doctl compute da power-off $(doctl compute d g $DROPLET_TARGET --format ID | tr -d 'ID' | xargs) --wait
    echo "Resizing Droplet to $SIZE"
    doctl compute da resize $(doctl compute d g $DROPLET_TARGET --format ID | tr -d 'ID' | xargs) --size $SIZE --wait
    echo "Powering on Droplet"
    doctl compute da power-on $(doctl compute d g $DROPLET_TARGET --format ID | tr -d 'ID' | xargs) --wait
    echo
    echo -e "\033[30;42m Success Fully Resizing $DROPLET_TARGET Droplet to $SIZE waiting for power on... \033[0m" >&1
    echo
    sleep 15
}

#######################################
# Sets current session Droplet target
#######################################
set_current_target() {
    while [[ -z "$DROPLET_TARGET" || ! $(doctl compute d g $DROPLET_TARGET) ]]; do
        read -p "Fill in Droplet target: " DROPLET_TARGET
    done
    echo "You choose: $DROPLET_TARGET for this session"
}

start_interactive_shell
