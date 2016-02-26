#!/bin/bash
#--------------------------------------------------------------------------------------------------
#@auther dreamingodd
#@20160226
#My project name is ocdp.
#1.git pull
#2.backup PHP
#3.deploy PHP.
#4.change config in PHP project.
#5.backup DB...
#6.deploy SQLs
#--------------------------------------------------------------------------------------------------

sys_time=`date "+%Y%m%d_%H%M%S"`
#Refresh git folder
echo "----1.git processing"
#Let's pretend your project is in /home/git/YourProjectName
if [ -d /home/git ]
then
    echo "Git folder exists."
    cd /home/git/YourProjectName
    git pull
else
    mkdir /home/git
    echo "created Git folder"
    cd /home/git
    git clone https://github.com/YourGitName/YourProjectName
fi

#Deploy YourProjectName
echo "----2.backing up PHP"
cd /var/www/html/
if [ -d /var/www/html/YourProjectName ]
then
    echo "YourProjectName exists."
    if [ -d /home/back ]
    then
        echo "Backup folder exists."
    else
        mkdir /home/back
    fi
    mv /var/www/html/YourProjectName /home/back/YourProjectName_${sys_time}
    mkdir /var/www/html/YourProjectName
else
    #some config file creation for the first time deployment.一些首次部署的config设置
    #...
    echo "YourProjectName config files are created."
fi
echo "----3.deploying PHP."
cd /var/www/html
cp -r /home/git/YourProjectName ./YourProjectName
#config change.你的项目部署需要的config修改
#...

#MySQL backup
echo "----5.backing up DB..."
backupFile=/tmp/DB_backup${sys_time}.sql
mysqldump -uroot -p${pwd} YourProjectName>${backupFile}

#MySQL script deployment
echo "----6.deploying SQLs"
if [ -f /home/git/YourProjectName/sql/deployment/*.sql ]
then
    for FILE in /home/git/YourProjectName/sql/deployment/*.sql
    do
        sys_time=`date "+%Y%m%d_%H%M%S"`
        mysql -uroot -p${pwd} -e "source $FILE" | tee /tmp/DB_log_${sys_time}.sql
    done
fi


