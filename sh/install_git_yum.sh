#!/bin/bash
#--------------------------------------------------------------------------------------------------
#@auther dreamingodd
#@20160226
#If failed, please
#1.Check your yum mirro source.
#2.Check the shell prililege.
#3.Run the following code line by line.
#--------------------------------------------------------------------------------------------------

#Git related
yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yum -y install git-core
git config --global user.name "Ye_WD"
git config --global user.email memorywilllast@sina.com

echo "Git installation completed."