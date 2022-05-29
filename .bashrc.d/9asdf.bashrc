# ASDF initialization.
export ASDF_DIR="$HOME/.asdf"

if [ -f $ASDF_DIR/asdf.sh ]; then
  . $ASDF_DIR/asdf.sh
  . $ASDF_DIR/completions/asdf.bash
fi
