#!/bin/bash
#
# Author: Abdulmelik Kalkan <kalkanabdulmelik@gmail.com>
#

cp /root/images/PrimaryProductName.png /usr/local/tomcat/webapps/fedlet/console/images/
sed -i -e '$a.MstDiv{background-color:white !important;}' /usr/local/tomcat/webapps/fedlet/com_sun_web_ui/css/css_ns6up.css
