#!/usr/bin/env bats

load helpers

setup() {
  setup_fake_bin
  setup_fake_home
}

teardown() {
  teardown_fake_bin
}

# ---------------------------------------------------------------------------
# macOS
# ---------------------------------------------------------------------------

@test "install: succeeds on macOS when mvim is available" {
  make_stub mvim
  run_script darwin19 "$REPO_ROOT/install"
  [ "$status" -eq 0 ]
  [[ "$output" == *"successfully installed"* ]]
}

@test "install: fails on macOS when mvim is missing" {
  run_script darwin19 "$REPO_ROOT/install"
  [ "$status" -eq 1 ]
  [[ "$output" == *"requires mvim"* ]]
}

@test "install: cleans up previous installation before reinstalling" {
  make_stub mvim
  mkdir -p "$HOME/.vim-anywhere"
  run_script darwin19 "$REPO_ROOT/install"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Cleaning up"* ]]
}

# ---------------------------------------------------------------------------
# Linux
# ---------------------------------------------------------------------------

@test "install: fails on Linux when gvim is missing" {
  make_stub gsettings
  make_stub xclip
  run_script linux-gnu "$REPO_ROOT/install"
  [ "$status" -eq 1 ]
  [[ "$output" == *"requires gvim"* ]]
}

@test "install: fails on Linux when xclip is missing" {
  make_stub gsettings
  make_stub gvim
  run_script linux-gnu "$REPO_ROOT/install"
  [ "$status" -eq 1 ]
  [[ "$output" == *"requires xclip"* ]]
}

@test "install: fails on Linux when no keybinding tool is present" {
  make_stub gvim
  make_stub xclip
  # Use minimal PATH: on Ubuntu /bin -> /usr/bin, so gsettings would be found
  # via ISOLATED_PATH even without a stub
  run_script_minimal linux-gnu "$REPO_ROOT/install"
  [ "$status" -eq 1 ]
  [[ "$output" == *"requires one of the following"* ]]
}

# ---------------------------------------------------------------------------
# Cross-platform
# ---------------------------------------------------------------------------

@test "install: fails on unsupported OS" {
  run_script windows "$REPO_ROOT/install"
  [ "$status" -eq 1 ]
  [[ "$output" == *"not supported"* ]]
}

@test "install: requires git" {
  make_stub mvim
  rm -f "$FAKE_BIN/git"
  # Use minimal PATH: on Ubuntu /bin -> /usr/bin, so system git would be found
  # via any PATH that includes /bin
  run_script_minimal darwin19 "$REPO_ROOT/install"
  [ "$status" -eq 1 ]
  [[ "$output" == *"requires git"* ]]
}
