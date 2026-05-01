#!/usr/bin/env bats

load helpers

setup() {
  setup_fake_bin
  setup_fake_home
  make_stub gsettings
}

teardown() {
  teardown_fake_bin
}

# ---------------------------------------------------------------------------
# macOS
# ---------------------------------------------------------------------------

@test "uninstall: removes AW_PATH on macOS" {
  mkdir -p "$HOME/.vim-anywhere"
  run_script darwin19 "$REPO_ROOT/uninstall"
  [ "$status" -eq 0 ]
  [ ! -d "$HOME/.vim-anywhere" ]
  [[ "$output" == *"successfully uninstalled"* ]]
}

@test "uninstall: removes workflow directory on macOS" {
  mkdir -p "$HOME/Library/Services/VimAnywhere.workflow"
  run_script darwin19 "$REPO_ROOT/uninstall"
  [ "$status" -eq 0 ]
  [ ! -d "$HOME/Library/Services/VimAnywhere.workflow" ]
}

@test "uninstall: succeeds even when AW_PATH does not exist" {
  run_script darwin19 "$REPO_ROOT/uninstall"
  [ "$status" -eq 0 ]
}

# ---------------------------------------------------------------------------
# Linux
# ---------------------------------------------------------------------------

@test "uninstall: removes gsettings binding on Linux" {
  mkdir -p "$HOME/.vim-anywhere"
  run_script linux-gnu "$REPO_ROOT/uninstall"
  [ "$status" -eq 0 ]
  [[ "$output" == *"successfully uninstalled"* ]]
}

@test "uninstall: uses gconftool when available on Linux" {
  make_stub gconftool
  mkdir -p "$HOME/.vim-anywhere"
  run_script linux-gnu "$REPO_ROOT/uninstall"
  [ "$status" -eq 0 ]
}
