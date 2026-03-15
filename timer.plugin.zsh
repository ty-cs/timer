# timer.plugin.zsh
# A minimal command timer for oh-my-zsh
# Place at: ~/.oh-my-zsh/custom/plugins/timer/timer.plugin.zsh
# Usage: add `timer` to plugins=() in ~/.zshrc

# ── Configuration ────────────────────────────────────────────────────────────
# TIMER_THRESHOLD  — minimum seconds before showing (default: 0, always show)
# TIMER_PRECISION  — decimal places for seconds (default: 3)
# TIMER_COLOR      — any color name valid in %F{} e.g. red, cyan, yellow (default: white)
# TIMER_FORMAT     — use %s as placeholder for elapsed time (default: "Time: %s")
# TIMER_SKIP_CMDS  — list of commands to skip timing (default: empty, e.g. (clear vi vim))

zmodload zsh/datetime

__timer_format_duration() {
  local -i mins=$(( $1 / 60 ))
  local secs=$(printf "%.${TIMER_PRECISION:-3}f" $(( $1 - 60 * mins )))
  local duration="${mins}m${secs}s"
  local color="%F{${TIMER_COLOR:-white}}"
  local format="${TIMER_FORMAT:-Time: %s}"
  print -P "${color}${format//\%s/${duration#0m}}%f"
}

__timer_preexec() {
  local cmd="${1%% *}"
  if (( ${+TIMER_SKIP_CMDS} )) && (( ${TIMER_SKIP_CMDS[(Ie)$cmd]} )); then
    return
  fi
  __timer_cmd_start_time=$EPOCHREALTIME
}

__timer_precmd() {
  [[ -z $__timer_cmd_start_time ]] && return

  local tdiff=$(( EPOCHREALTIME - __timer_cmd_start_time ))
  unset __timer_cmd_start_time

  (( tdiff < 0 )) && tdiff=0

  if [[ -z $TIMER_THRESHOLD ]] || (( tdiff >= TIMER_THRESHOLD )); then
    __timer_format_duration "$tdiff"
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec __timer_preexec
add-zsh-hook precmd  __timer_precmd
