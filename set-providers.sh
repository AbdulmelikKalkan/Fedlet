#!/bin/bash
#
# Author: Abdulmelik Kalkan <kalkanabdulmelik@gmail.com>
#

#set -eo pipefail

sed -i "/sun-fm-trusted-providers/c\sun-fm-trusted-providers=$1, $2" ./fedlet/*.cot
sed -i -r 's,(entityID=")[^"]+",\1'"$1"'",' ./fedlet/idp-extended.xml
