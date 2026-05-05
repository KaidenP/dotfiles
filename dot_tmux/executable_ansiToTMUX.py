#!/usr/bin/env python3
"""
A hacky script to convert ohmyposh to tmux format string
"""
import re
import sys

def rgb_to_hex(r, g, b):
    return f"{int(r):02x}{int(g):02x}{int(b):02x}"

def replace(match):
    mode = match.group(1)  # 38 or 48
    r, g, b = match.group(2), match.group(3), match.group(4)
    hex_color = rgb_to_hex(r, g, b)

    if mode == "38":
        return f"#[fg=#{hex_color}]"
    else:
        return f"#[bg=#{hex_color}]"

pattern = re.compile(r'\x1b\[(38|48);2;(\d+);(\d+);(\d+)m')

text = sys.stdin.read()
text = pattern.sub(replace, text)

# reset
text = re.sub(r'\x1b\[0m', '#[default]', text)

# Remove everything after ESC ] 0;
text = re.sub(r'\x1b\]0;.*', '', text, flags=re.DOTALL)

# Remove OSC sequences (ESC ] ... BEL or ESC \)
text = re.sub(r'\x1b\].*?(\x07|\x1b\\)', '', text, flags=re.DOTALL)

# Remove CSI sequences (ESC [ ... letter)
text = re.sub(r'\x1b\[[0-?]*[ -/]*[@-~]', '', text)

# Remove any remaining ESC sequences
text = re.sub(r'\x1b[@-_]', '', text)

print(text, end="")