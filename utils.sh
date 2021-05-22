#!/bin/bash
#
# Author: Abdulmelik Kalkan <kalkanabdulmelik@gmail.com>
#


check_env_var() {
  var_name=$1

  if [ "${!var_name}" = "" ]; then
    echo "You must set $1 before running these scripts."
    exit 1
  fi
}
