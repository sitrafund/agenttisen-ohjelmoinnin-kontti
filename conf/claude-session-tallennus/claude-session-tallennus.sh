#!/usr/bin/env bash

CLAUDE_JSON="/root/.claude.json"
CLAUDE_DIR="/root/.claude"
DEST="/root/claude-session-tallennus"

inotifywait -m -e close_write,create,delete,move "$CLAUDE_JSON" "$CLAUDE_DIR" --format '%w%f' |
while read CHANGE; do
  cp "$CLAUDE_JSON" "$DEST"/
  rsync -a --delete "$CLAUDE_DIR/" "$DEST/$(basename "$CLAUDE_DIR")/"
done
