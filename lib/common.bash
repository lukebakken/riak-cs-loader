set -o errexit
set -o errtrace

bname="$(basename $0)"

function make_temp_dir
{
  local  __resultvar=$1

  local tempfoo="${bname}.XXXXXXXXXX"
  local tempdir=$(mktemp -d -t "$tempfoo")

  if [[ -n "$__resultvar" ]]
  then
    eval $__resultvar="'$tempdir'"
  else
    echo "$tempdir"
  fi
}

function make_temp_file
{
  local  __resultvar=$1

  local tempfoo="${bname}.XXXXXXXXXX"
  local tempfile=$(mktemp -t "$tempfoo")

  if [[ -n "$__resultvar" ]]
  then
    eval $__resultvar="'$tempfile'"
  else
    echo "$tempfile"
  fi
}

function now
{
  date '+%Y-%m-%d %H:%M:%S'
}

function pwarn
{
  echo "$(now) [warning]: $@" 1>&2
}

function perr
{
  echo "$(now) [error]: $@" 1>&2
}

function pinfo
{
  echo "$(now) [info]: $@"
}

function errexit
{
  perr "$@"
  exit 1
}

function check_s3cmd_env
{
  if [[ -d ./s3cmd-env ]]
  then
    source ./s3cmd-env/bin/activate
    # NB: the following doesn't seem to work
    # if ! pip list | fgrep -q python-dateutil
    # then
    #   errexit 'Please source s3cmd-env/bin/activate then run "pip install python-dateutil"'
    # fi
    # if ! pip list | fgrep -q python-magic
    # then
    #   errexit 'Please source s3cmd-env/bin/activate then run "pip install python-magic"'
    # fi
  else
    errexit 'Please use virtualenv to create a python env named "s3cmd-env" with python-dateutil and python-magic libs installed.'
  fi
}

function check_s3cmd
{
  check_s3cmd_env
  if [[ ! -x ./s3cmd/s3cmd ]]
  then
    errexit 'Please ensure that you check out this repo and include submodules.'
  fi
}

