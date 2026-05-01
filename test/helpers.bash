# Shared setup helpers for vim-anywhere bats tests.
#
# Each test file sources this via `load helpers`.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAKE_BIN="$BATS_TMPDIR/fake-bin"
# Excludes Homebrew dirs (/opt/homebrew/bin, /usr/local/bin) so only FAKE_BIN
# stubs and essential POSIX tools are found.
ISOLATED_PATH="$FAKE_BIN:/usr/bin:/bin"

# Write an executable stub to FAKE_BIN. $body defaults to `true` (no-op).
make_stub() {
  local name="$1"
  local body="${2:-true}"
  printf '#!/bin/bash\n%s\n' "$body" > "$FAKE_BIN/$name"
  chmod +x "$FAKE_BIN/$name"
}

setup_fake_bin() {
  mkdir -p "$FAKE_BIN"

  # git clone: create the target dir and seed VimAnywhere.workflow so the macOS
  # installer can cp it into ~/Library/Services. rev-parse: signal "not a git repo".
  make_stub git "case \"\$1\" in
    clone) mkdir -p \"\$3\" && cp -R \"$REPO_ROOT/VimAnywhere.workflow\" \"\$3/\" ;;
    rev-parse) exit 1 ;;
  esac"

  # which: return the stub path for any queried tool
  make_stub which "echo \"$FAKE_BIN/\$1\""

  # macOS system tools that would have real side effects
  make_stub defaults
  make_stub osascript 'echo "Finder"'
}

teardown_fake_bin() {
  rm -rf "$FAKE_BIN"
}

# Override HOME so scripts don't touch the real user directory.
setup_fake_home() {
  export HOME="$BATS_TMPDIR/home"
  mkdir -p "$HOME"
}

# Run a vim-anywhere script with ISOLATED_PATH and explicit OSTYPE.
# Uses `source` inside bash -c so OSTYPE can be set before the script reads it
# (bash overwrites OSTYPE from the environment at startup, but an assignment
# inside the same shell takes effect before the sourced script runs).
# Both stdout and stderr are captured in $output.
run_script() {
  local ostype="$1"
  local script="$2"
  run env HOME="$HOME" PATH="$ISOLATED_PATH" \
    bash -c "OSTYPE=$ostype; source \"$script\" 2>&1"
}
