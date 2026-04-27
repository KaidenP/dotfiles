#!/usr/bin/env zsh

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      source $i
    fi
  done
  unset i
fi

if [ -d "$HOME/profile.d" ]; then
  for i in "$HOME/profile.d/"*.sh; do
    if [ -r "$i" ]; then
      source $i
    fi
  done
  unset i
fi