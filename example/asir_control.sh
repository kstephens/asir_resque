#!/bin/sh
set -x
dir="$(cd "$(dirname $0)" && /bin/pwd)"
PATH="$dir/../bin:$PATH"
export RUBYLIB="$dir/../example:$dir/../lib"
asir="asir verbose=9 config_rb=$dir/config/asir_config.rb" 
args="$*"
args="${args:-ALL}"
# set -e

#############################

case "$args"
in
  *resque*|*ALL*)

$asir start resque conduit
sleep 1
if $asir alive resque conduit; then
  echo "resque conduit alive"
fi
$asir start resque worker
sleep 1
$asir pid resque worker
if $asir alive resque worker; then
  echo "resque worker alive"
fi

ruby "$dir/asir_control_client_resque.rb"
sleep 1
$asir stop resque worker
sleep 1
$asir stop resque conduit

;;
esac

#############################

exit 0
