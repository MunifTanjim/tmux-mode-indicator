#!/usr/bin/env bash

set -e

mode_indicator_placeholder="\#{tmux_mode_indicator}"

prefix_prompt_config='@mode_indicator_prefix_prompt'
copy_prompt_config='@mode_indicator_copy_prompt'
sync_prompt_config='@mode_indicator_sync_prompt'
empty_prompt_config='@mode_indicator_empty_prompt'
prefix_mode_style_config='@mode_indicator_prefix_mode_style'
copy_mode_style_config='@mode_indicator_copy_mode_style'
sync_mode_style_config='@mode_indicator_sync_mode_style'
empty_mode_style_config='@mode_indicator_empty_mode_style'

tmux_option() {
  local -r option=$(tmux show-option -gqv "$1")
  local -r fallback="$2"
  echo "${option:-$fallback}"
}

indicator_style() {
  local -r style=$(tmux_option "$1" "$2")
  echo "${style:+#[${style/,/]#[}]}"
}

init_tmux_mode_indicator() {
  local -r \
    prefix_prompt=$(tmux_option "$prefix_prompt_config" " WAIT ") \
    copy_prompt=$(tmux_option "$copy_prompt_config" " COPY ") \
    sync_prompt=$(tmux_option "$sync_prompt_config" " SYNC ") \
    empty_prompt=$(tmux_option "$empty_prompt_config" " TMUX ") \
    prefix_style=$(indicator_style "$prefix_mode_style_config" "bg=blue,fg=black") \
    copy_style=$(indicator_style "$copy_mode_style_config" "bg=yellow,fg=black") \
    sync_style=$(indicator_style "$sync_mode_style_config" "bg=red,fg=black") \
    empty_style=$(indicator_style "$empty_mode_style_config" "bg=cyan,fg=black")

  local -r \
    mode_prompt="#{?client_prefix,$prefix_prompt,#{?pane_in_mode,$copy_prompt,#{?pane_synchronized,$sync_prompt,$empty_prompt}}}" \
    mode_style="#{?client_prefix,$prefix_style,#{?pane_in_mode,$copy_style,#{?pane_synchronized,$sync_style,$empty_style}}}"

  local -r mode_indicator="#[default]$mode_style$mode_prompt#[default]"

  local -r status_left_value="$(tmux_option "status-left")"
  tmux set-option -gq "status-left" "${status_left_value/$mode_indicator_placeholder/$mode_indicator}"

  local -r status_right_value="$(tmux_option "status-right")"
  tmux set-option -gq "status-right" "${status_right_value/$mode_indicator_placeholder/$mode_indicator}"
}

init_tmux_mode_indicator
