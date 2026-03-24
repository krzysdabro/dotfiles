#!/bin/sh
op run --environment=$(cat ~/.claude/op-env-id) --no-masking -- $HOMEBREW_PREFIX/bin/claude $@
