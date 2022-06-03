# ASDF initialization.
export ASDF_DIR="$HOME/.asdf"

if [ -r $ASDF_DIR/asdf.sh ]; then
  . $ASDF_DIR/asdf.sh
  . $ASDF_DIR/completions/asdf.bash

  # https://github.com/halcyon/asdf-java
  if [ -r $ASDF_DIR/plugins/java/set-java-home.bash ]; then
    . $ASDF_DIR/plugins/java/set-java-home.bash
  fi
fi
