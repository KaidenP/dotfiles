#!/usr/bin/env zsh

if [ -d /etc/profile.d ]; then
  for i in $(printf '%s\n' /etc/profile.d/*.sh | LC_ALL=C sort -V); do
    if [ -r "$i" ]; then
      source "$i"
    fi
  done
  unset i
fi

if [ -d "$HOME/profile.d" ]; then
  for i in $(printf '%s\n' "$HOME/profile.d/"*.sh | LC_ALL=C sort -V); do
    if [ -r "$i" ]; then
      source "$i"
    fi
  done
  unset i
fi