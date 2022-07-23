#!/usr/bin/env bash
#
# quarkus Bash Completion
# =======================
#
# Bash completion support for the `quarkus` command,
# generated by [picocli](http://picocli.info/) version 4.6.3.
#
# Installation
# ------------
#
# 1. Source all completion scripts in your .bash_profile
#
#   cd $YOUR_APP_HOME/bin
#   for f in $(find . -name "*_completion"); do line=". $(pwd)/$f"; grep "$line" ~/.bash_profile || echo "$line" >> ~/.bash_profile; done
#
# 2. Open a new bash console, and type `quarkus [TAB][TAB]`
#
# 1a. Alternatively, if you have [bash-completion](https://github.com/scop/bash-completion) installed:
#     Place this file in a `bash-completion.d` folder:
#
#   * /etc/bash-completion.d
#   * /usr/local/etc/bash-completion.d
#   * ~/bash-completion.d
#
# Documentation
# -------------
# The script is called by bash whenever [TAB] or [TAB][TAB] is pressed after
# 'quarkus (..)'. By reading entered command line parameters,
# it determines possible bash completions and writes them to the COMPREPLY variable.
# Bash then completes the user input if only one entry is listed in the variable or
# shows the options if more than one is listed in COMPREPLY.
#
# References
# ----------
# [1] http://stackoverflow.com/a/12495480/1440785
# [2] http://tiswww.case.edu/php/chet/bash/FAQ
# [3] https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# [4] http://zsh.sourceforge.net/Doc/Release/Options.html#index-COMPLETE_005fALIASES
# [5] https://stackoverflow.com/questions/17042057/bash-check-element-in-array-for-elements-in-another-array/17042655#17042655
# [6] https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html#Programmable-Completion
# [7] https://stackoverflow.com/questions/3249432/can-a-bash-tab-completion-script-be-used-in-zsh/27853970#27853970
#

if [ -n "$BASH_VERSION" ]; then
  # Enable programmable completion facilities when using bash (see [3])
  shopt -s progcomp
elif [ -n "$ZSH_VERSION" ]; then
  # Make alias a distinct command for completion purposes when using zsh (see [4])
  setopt COMPLETE_ALIASES
  alias compopt=complete

  # Enable bash completion in zsh (see [7])
  # Only initialize completions module once to avoid unregistering existing completions.
  if ! type compdef > /dev/null; then
    autoload -U +X compinit && compinit
  fi
  autoload -U +X bashcompinit && bashcompinit
fi

# CompWordsContainsArray takes an array and then checks
# if all elements of this array are in the global COMP_WORDS array.
#
# Returns zero (no error) if all elements of the array are in the COMP_WORDS array,
# otherwise returns 1 (error).
function CompWordsContainsArray() {
  declare -a localArray
  localArray=("$@")
  local findme
  for findme in "${localArray[@]}"; do
    if ElementNotInCompWords "$findme"; then return 1; fi
  done
  return 0
}
function ElementNotInCompWords() {
  local findme="$1"
  local element
  for element in "${COMP_WORDS[@]}"; do
    if [[ "$findme" = "$element" ]]; then return 1; fi
  done
  return 0
}

# The `currentPositionalIndex` function calculates the index of the current positional parameter.
#
# currentPositionalIndex takes three parameters:
# the command name,
# a space-separated string with the names of options that take a parameter, and
# a space-separated string with the names of boolean options (that don't take any params).
# When done, this function echos the current positional index to std_out.
#
# Example usage:
# local currIndex=$(currentPositionalIndex "mysubcommand" "$ARG_OPTS" "$FLAG_OPTS")
function currentPositionalIndex() {
  local commandName="$1"
  local optionsWithArgs="$2"
  local booleanOptions="$3"
  local previousWord
  local result=0

  for i in $(seq $((COMP_CWORD - 1)) -1 0); do
    previousWord=${COMP_WORDS[i]}
    if [ "${previousWord}" = "$commandName" ]; then
      break
    fi
    if [[ "${optionsWithArgs}" =~ ${previousWord} ]]; then
      ((result-=2)) # Arg option and its value not counted as positional param
    elif [[ "${booleanOptions}" =~ ${previousWord} ]]; then
      ((result-=1)) # Flag option itself not counted as positional param
    fi
    ((result++))
  done
  echo "$result"
}

# Bash completion entry point function.
# _complete_quarkus finds which commands and subcommands have been specified
# on the command line and delegates to the appropriate function
# to generate possible options and subcommands for the last specified subcommand.
function _complete_quarkus() {
  # Edge case: if command line has no space after subcommand, then don't assume this subcommand is selected (remkop/picocli#1468).
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} create" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} build" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} dev" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} extension" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} ext" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} registry" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} info" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} update" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} version" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} completion" ];    then _picocli_quarkus; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} create app" ];    then _picocli_quarkus_create; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} create cli" ];    then _picocli_quarkus_create; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} create extension" ];    then _picocli_quarkus_create; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} extension list" ];    then _picocli_quarkus_extension; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} extension ls" ];    then _picocli_quarkus_extension; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} extension categories" ];    then _picocli_quarkus_extension; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} extension cat" ];    then _picocli_quarkus_extension; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} extension add" ];    then _picocli_quarkus_extension; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} extension remove" ];    then _picocli_quarkus_extension; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} extension rm" ];    then _picocli_quarkus_extension; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} ext list" ];    then _picocli_quarkus_ext; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} ext ls" ];    then _picocli_quarkus_ext; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} ext categories" ];    then _picocli_quarkus_ext; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} ext cat" ];    then _picocli_quarkus_ext; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} ext add" ];    then _picocli_quarkus_ext; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} ext remove" ];    then _picocli_quarkus_ext; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} ext rm" ];    then _picocli_quarkus_ext; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} registry list" ];    then _picocli_quarkus_registry; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} registry add" ];    then _picocli_quarkus_registry; return $?; fi
  if [ "${COMP_LINE}" = "${COMP_WORDS[0]} registry remove" ];    then _picocli_quarkus_registry; return $?; fi

  # Find the longest sequence of subcommands and call the bash function for that subcommand.
  local cmds0=(create)
  local cmds1=(build)
  local cmds2=(dev)
  local cmds3=(extension)
  local cmds4=(ext)
  local cmds5=(registry)
  local cmds6=(info)
  local cmds7=(update)
  local cmds8=(version)
  local cmds9=(completion)
  local cmds10=(create app)
  local cmds11=(create cli)
  local cmds12=(create extension)
  local cmds13=(extension list)
  local cmds14=(extension ls)
  local cmds15=(extension categories)
  local cmds16=(extension cat)
  local cmds17=(extension add)
  local cmds18=(extension remove)
  local cmds19=(extension rm)
  local cmds20=(ext list)
  local cmds21=(ext ls)
  local cmds22=(ext categories)
  local cmds23=(ext cat)
  local cmds24=(ext add)
  local cmds25=(ext remove)
  local cmds26=(ext rm)
  local cmds27=(registry list)
  local cmds28=(registry add)
  local cmds29=(registry remove)

  if CompWordsContainsArray "${cmds29[@]}"; then _picocli_quarkus_registry_remove; return $?; fi
  if CompWordsContainsArray "${cmds28[@]}"; then _picocli_quarkus_registry_add; return $?; fi
  if CompWordsContainsArray "${cmds27[@]}"; then _picocli_quarkus_registry_list; return $?; fi
  if CompWordsContainsArray "${cmds26[@]}"; then _picocli_quarkus_ext_rm; return $?; fi
  if CompWordsContainsArray "${cmds25[@]}"; then _picocli_quarkus_ext_remove; return $?; fi
  if CompWordsContainsArray "${cmds24[@]}"; then _picocli_quarkus_ext_add; return $?; fi
  if CompWordsContainsArray "${cmds23[@]}"; then _picocli_quarkus_ext_cat; return $?; fi
  if CompWordsContainsArray "${cmds22[@]}"; then _picocli_quarkus_ext_categories; return $?; fi
  if CompWordsContainsArray "${cmds21[@]}"; then _picocli_quarkus_ext_ls; return $?; fi
  if CompWordsContainsArray "${cmds20[@]}"; then _picocli_quarkus_ext_list; return $?; fi
  if CompWordsContainsArray "${cmds19[@]}"; then _picocli_quarkus_extension_rm; return $?; fi
  if CompWordsContainsArray "${cmds18[@]}"; then _picocli_quarkus_extension_remove; return $?; fi
  if CompWordsContainsArray "${cmds17[@]}"; then _picocli_quarkus_extension_add; return $?; fi
  if CompWordsContainsArray "${cmds16[@]}"; then _picocli_quarkus_extension_cat; return $?; fi
  if CompWordsContainsArray "${cmds15[@]}"; then _picocli_quarkus_extension_categories; return $?; fi
  if CompWordsContainsArray "${cmds14[@]}"; then _picocli_quarkus_extension_ls; return $?; fi
  if CompWordsContainsArray "${cmds13[@]}"; then _picocli_quarkus_extension_list; return $?; fi
  if CompWordsContainsArray "${cmds12[@]}"; then _picocli_quarkus_create_extension; return $?; fi
  if CompWordsContainsArray "${cmds11[@]}"; then _picocli_quarkus_create_cli; return $?; fi
  if CompWordsContainsArray "${cmds10[@]}"; then _picocli_quarkus_create_app; return $?; fi
  if CompWordsContainsArray "${cmds9[@]}"; then _picocli_quarkus_completion; return $?; fi
  if CompWordsContainsArray "${cmds8[@]}"; then _picocli_quarkus_version; return $?; fi
  if CompWordsContainsArray "${cmds7[@]}"; then _picocli_quarkus_update; return $?; fi
  if CompWordsContainsArray "${cmds6[@]}"; then _picocli_quarkus_info; return $?; fi
  if CompWordsContainsArray "${cmds5[@]}"; then _picocli_quarkus_registry; return $?; fi
  if CompWordsContainsArray "${cmds4[@]}"; then _picocli_quarkus_ext; return $?; fi
  if CompWordsContainsArray "${cmds3[@]}"; then _picocli_quarkus_extension; return $?; fi
  if CompWordsContainsArray "${cmds2[@]}"; then _picocli_quarkus_dev; return $?; fi
  if CompWordsContainsArray "${cmds1[@]}"; then _picocli_quarkus_build; return $?; fi
  if CompWordsContainsArray "${cmds0[@]}"; then _picocli_quarkus_create; return $?; fi

  # No subcommands were specified; generate completions for the top-level command.
  _picocli_quarkus; return $?;
}

# Generates completions for the options and subcommands of the `quarkus` command.
function _picocli_quarkus() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands="create build dev extension ext registry info update version completion"
  local flag_opts="-h --help -v --version -e --errors --verbose"
  local arg_opts="-D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `create` subcommand.
function _picocli_quarkus_create() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands="app cli extension"
  local flag_opts="-e --errors --verbose -h --help"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `build` subcommand.
function _picocli_quarkus_build() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run --clean --native --offline --no-tests"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `dev` subcommand.
function _picocli_quarkus_dev() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help --dry-run --clean --offline --no-debug --suspend"
  local arg_opts="--config -D --debug-host --debug-mode --debug-port"
  local mode_option_args="connect listen" # --debug-mode values

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    --debug-host)
      return
      ;;
    --debug-mode)
      COMPREPLY=( $( compgen -W "${mode_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --debug-port)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `extension` subcommand.
function _picocli_quarkus_extension() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands="list ls categories cat add remove rm"
  local flag_opts="-e --errors --verbose"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `ext` subcommand.
function _picocli_quarkus_ext() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands="list ls categories cat add remove rm"
  local flag_opts="-e --errors --verbose"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `registry` subcommand.
function _picocli_quarkus_registry() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands="list add remove"
  local flag_opts="-e --errors --verbose -h --help"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `info` subcommand.
function _picocli_quarkus_info() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help --per-module"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `update` subcommand.
function _picocli_quarkus_update() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help --rectify --recommended-state --per-module"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `version` subcommand.
function _picocli_quarkus_version() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose -h --help --dependencies"
  local arg_opts="-D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `completion` subcommand.
function _picocli_quarkus_completion() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}

  local commands=""
  local flag_opts="-h --help -V --version"
  local arg_opts=""

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `app` subcommand.
function _picocli_quarkus_create_app() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-B --batch-mode --dry-run -e --errors --verbose --refresh --registry-client -h --help --jbang --maven --gradle --gradle-kotlin-dsl --kotlin --scala --no-wrapper --no-code"
  local arg_opts="--config -o --output-directory -x --extension --extensions -S --stream -P --platform-bom --java --package-name -c --app-config -D"
  local javaVersion_option_args="11 17" # --java values

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -o|--output-directory)
      return
      ;;
    -x|--extension|--extensions)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
    --java)
      COMPREPLY=( $( compgen -W "${javaVersion_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --package-name)
      return
      ;;
    -c|--app-config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `cli` subcommand.
function _picocli_quarkus_create_cli() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-B --batch-mode --dry-run -e --errors --verbose --refresh --registry-client -h --help --jbang --maven --gradle --gradle-kotlin-dsl --kotlin --scala --no-wrapper --no-code"
  local arg_opts="--config -o --output-directory -x --extension --extensions -S --stream -P --platform-bom --java --package-name -c --app-config -D"
  local javaVersion_option_args="11 17" # --java values

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -o|--output-directory)
      return
      ;;
    -x|--extension|--extensions)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
    --java)
      COMPREPLY=( $( compgen -W "${javaVersion_option_args}" -- "${curr_word}" ) )
      return $?
      ;;
    --package-name)
      return
      ;;
    -c|--app-config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `extension` subcommand.
function _picocli_quarkus_create_extension() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-B --batch-mode --dry-run -e --errors --verbose --refresh --registry-client -h --help --no-unit-test --no-it-test --no-devmode-test"
  local arg_opts="--config -o --output-directory -S --stream -P --platform-bom -N --namespace-id --extension-name --extension-description --namespace-name --package-name --without-tests -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -o|--output-directory)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
    -N|--namespace-id)
      return
      ;;
    --extension-name)
      return
      ;;
    --extension-description)
      return
      ;;
    --namespace-name)
      return
      ;;
    --package-name)
      return
      ;;
    --without-tests)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `list` subcommand.
function _picocli_quarkus_extension_list() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run -i --installable --id --concise --full --origins"
  local arg_opts="--config -D -S --stream -P --platform-bom -s --search -c --category"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
    -s|--search)
      return
      ;;
    -c|--category)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `ls` subcommand.
function _picocli_quarkus_extension_ls() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run -i --installable --id --concise --full --origins"
  local arg_opts="--config -D -S --stream -P --platform-bom -s --search -c --category"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
    -s|--search)
      return
      ;;
    -c|--category)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `categories` subcommand.
function _picocli_quarkus_extension_categories() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run --id --concise --full"
  local arg_opts="--config -D -S --stream -P --platform-bom"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `cat` subcommand.
function _picocli_quarkus_extension_cat() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run --id --concise --full"
  local arg_opts="--config -D -S --stream -P --platform-bom"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `add` subcommand.
function _picocli_quarkus_extension_add() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `remove` subcommand.
function _picocli_quarkus_extension_remove() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `rm` subcommand.
function _picocli_quarkus_extension_rm() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `list` subcommand.
function _picocli_quarkus_ext_list() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run -i --installable --id --concise --full --origins"
  local arg_opts="--config -D -S --stream -P --platform-bom -s --search -c --category"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
    -s|--search)
      return
      ;;
    -c|--category)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `ls` subcommand.
function _picocli_quarkus_ext_ls() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run -i --installable --id --concise --full --origins"
  local arg_opts="--config -D -S --stream -P --platform-bom -s --search -c --category"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
    -s|--search)
      return
      ;;
    -c|--category)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `categories` subcommand.
function _picocli_quarkus_ext_categories() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run --id --concise --full"
  local arg_opts="--config -D -S --stream -P --platform-bom"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `cat` subcommand.
function _picocli_quarkus_ext_cat() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run --id --concise --full"
  local arg_opts="--config -D -S --stream -P --platform-bom"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
    -S|--stream)
      return
      ;;
    -P|--platform-bom)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `add` subcommand.
function _picocli_quarkus_ext_add() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `remove` subcommand.
function _picocli_quarkus_ext_remove() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `rm` subcommand.
function _picocli_quarkus_ext_rm() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh --registry-client -h --help -B --batch-mode --dry-run"
  local arg_opts="--config -D"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
    -D)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `list` subcommand.
function _picocli_quarkus_registry_list() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh -h --help --streams"
  local arg_opts="--config"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `add` subcommand.
function _picocli_quarkus_registry_add() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh -h --help"
  local arg_opts="--config"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Generates completions for the options and subcommands of the `remove` subcommand.
function _picocli_quarkus_registry_remove() {
  # Get completion data
  local curr_word=${COMP_WORDS[COMP_CWORD]}
  local prev_word=${COMP_WORDS[COMP_CWORD-1]}

  local commands=""
  local flag_opts="-e --errors --verbose --refresh -h --help"
  local arg_opts="--config"

  type compopt &>/dev/null && compopt +o default

  case ${prev_word} in
    --config)
      return
      ;;
  esac

  if [[ "${curr_word}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${flag_opts} ${arg_opts}" -- "${curr_word}") )
  else
    local positionals=""
    COMPREPLY=( $(compgen -W "${commands} ${positionals}" -- "${curr_word}") )
  fi
}

# Define a completion specification (a compspec) for the
# `quarkus`, `quarkus.sh`, and `quarkus.bash` commands.
# Uses the bash `complete` builtin (see [6]) to specify that shell function
# `_complete_quarkus` is responsible for generating possible completions for the
# current word on the command line.
# The `-o default` option means that if the function generated no matches, the
# default Bash completions and the Readline default filename completions are performed.
complete -F _complete_quarkus -o default quarkus quarkus.sh quarkus.bash

