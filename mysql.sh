source common.sh

if [ -z "$1" ]; then
  echo Password Input Missing
  exit
fi

MYSQL_ROOT_PASSWORD=$1

echo -e "\e[35m Disable existing mysql module \e[0m"
dnf module disable mysql -y &>>/tmp/mysql.log
status_check

echo -e "\e[35m Create mysql repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/mysql.log
status_check

echo -e "\e[35m install mysql community server \e[0m"
dnf install mysql-community-server -y &>>/tmp/mysql.log
status_check

echo -e "\e[35m enable and restart mysql server \e[0m"
systemctl enable mysqld &>>/tmp/mysql.log
systemctl start mysqld &>>/tmp/mysql.log
status_check

echo -e "\e[35m set the password for sql database \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD} &>>/tmp/mysql.log
status_check
