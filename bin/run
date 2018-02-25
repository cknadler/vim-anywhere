#!/bin/bash
#
# vim-anywhere - use Vim whenever, wherever
# Author: Chris Knadler
# Homepage: https://www.github.com/cknadler/vim-anywhere
#
# Open a temporary file with Vim. Once Vim is closed, copy the contents of that
# file to the system clipboard.

###
# defs
###

err() { echo -e "$@" 1>&2; }

require_file_exists() {
  if [ ! -e $1 ]; then
    err "$1 does not exist. ${@:2}"
    exit 1
  fi
}

###
# opts
###

while getopts ":v" opt; do
  case "$opt" in
    v) set -x ;;
    \?) echo "Invalid option: -$OPTARG" >&2 ;;
  esac
done

###
# run
###

AW_PATH=$HOME/.vim-anywhere
TMPFILE_DIR=/tmp/vim-anywhere
TMPFILE=$TMPFILE_DIR/doc-$(date +"%y%m%d%H%M%S")
VIM_OPTS=--nofork

# Use ~/.gvimrc.min or ~/.vimrc.min if one exists
VIMRC_PATH=($HOME/.gvimrc.min $HOME/.vimrc.min)

for vimrc_path in "${VIMRC_PATH[@]}"; do
    if [ -f $vimrc_path ]; then
        VIM_OPTS+=" -u $vimrc_path"
        break
    fi
done

mkdir -p $TMPFILE_DIR
touch $TMPFILE

# Linux
if [[ $OSTYPE == "linux-gnu" ]]; then
  chmod o-r $TMPFILE # Make file only readable by you
  gvim $VIM_OPTS $TMPFILE
  cat $TMPFILE | xclip -selection clipboard

# OSX
elif [[ $OSTYPE == "darwin"* ]]; then
  # if there is no path file, it must have been deleted or the installer failed
  require_file_exists $AW_PATH/.path \
    "Please reinstall vim-anywhere."

  app=$(osascript $AW_PATH/script/current_app.scpt)
  mvim_path=$(cat $AW_PATH/.path)

  require_file_exists $mvim_path \
    "mvim must have been moved or uninstalled.\nPlease make sure it is" \
    "available in your path and then reinstall vim-anywhere."

  $mvim_path $VIM_OPTS $TMPFILE
  # todo, fix invalid file

  # NOTE
  # Here we set LANG explicitly to be UTF-8 compatible when copying text. The only way that was explicitly
  # setting this to en_US.UTF-8. This may eventually cause issues with other languages. If so, just remove
  # the LANG setting.
  LANG=en_US.UTF-8 pbcopy < $TMPFILE
  osascript -e "activate application \"$app\""
fi
