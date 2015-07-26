#!/usr/bin/env bash

initialize

proxy_status=
proxy_status_interpolation=

get_proxy_status() {
  local proxy="$(tmux showenv -g http_proxy)"
  [ -n "$proxy" ] && echo "on" || echo "off"
}

proxy_status="proxy: $(get_proxy_status)"
proxy_status_interpolation="\#{proxy_status}"

get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value="$(tmux show-option -gqv "$option")"
	[ -z "$option_value" ] && echo "$default_value" || echo "$option_value"
}

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local string="$1"
	local status=$"${string/$proxy_status_interpolation/$proxy_status}"
	echo "$status"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-left"
  update_tmux_option "status-right"
}

main
