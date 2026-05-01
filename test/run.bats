#!/usr/bin/env bats

load helpers

# Mirror the path logic from bin/run so tests check the right location
VIM_ANYWHERE_TMPDIR="${TMPDIR:-/tmp}/vim-anywhere"

setup() {
  setup_fake_bin
  setup_fake_home

  # Simulate an installed vim-anywhere with a working mvim stub
  local aw_path="$HOME/.vim-anywhere"
  mkdir -p "$aw_path/script"
  cp "$REPO_ROOT/script/current_app.scpt" "$aw_path/script/current_app.scpt"

  make_stub mvim 'touch "${@: -1}"'
  echo "$FAKE_BIN/mvim" > "$aw_path/.path"

  make_stub pbcopy
}

teardown() {
  teardown_fake_bin
  rm -rf "$VIM_ANYWHERE_TMPDIR"
}

@test "run: creates temp directory and file" {
  run_script darwin19 "$REPO_ROOT/bin/run"
  [ "$status" -eq 0 ]
  [ -d "$VIM_ANYWHERE_TMPDIR" ]
}

@test "run: fails when .path file is missing on macOS" {
  rm "$HOME/.vim-anywhere/.path"
  run_script darwin19 "$REPO_ROOT/bin/run"
  [ "$status" -eq 1 ]
  [[ "$output" == *"does not exist"* ]]
}

@test "run: fails when mvim binary is missing on macOS" {
  echo "/nonexistent/mvim" > "$HOME/.vim-anywhere/.path"
  run_script darwin19 "$REPO_ROOT/bin/run"
  [ "$status" -eq 1 ]
  [[ "$output" == *"does not exist"* ]]
}

@test "run: copies temp file to clipboard via pbcopy on macOS" {
  make_stub pbcopy "echo 'pbcopy called' >> \"\${TMPDIR:-/tmp}/vim-anywhere/pbcopy.log\""
  run_script darwin19 "$REPO_ROOT/bin/run"
  [ "$status" -eq 0 ]
  [ -f "$VIM_ANYWHERE_TMPDIR/pbcopy.log" ]
}

@test "run: uses custom vimrc when ~/.vimrc.min exists" {
  echo "set nocompatible" > "$HOME/.vimrc.min"
  make_stub mvim "echo \"\$@\" > \"\${TMPDIR:-/tmp}/vim-anywhere/mvim.args\"; touch \"\${@: -1}\""
  run_script darwin19 "$REPO_ROOT/bin/run"
  [ "$status" -eq 0 ]
  grep -q "\.vimrc\.min" "$VIM_ANYWHERE_TMPDIR/mvim.args"
}
