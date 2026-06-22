#!/bin/sh
op run --environment=$(cat $HOME/.claude/op-env-id) --no-masking -- $@
