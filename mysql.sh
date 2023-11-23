echo -e "\e[35m Disable existing mysql module \e[0m"
dnf module disable mysql -y
echo $?

echo -e "\e[35m Create mysql repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo
echo $?

echo -e "\e[35m install mysql community server \e[0m"
dnf install mysql-community-server -y
echo $?

echo -e "\e[35m enable and restart mysql server \e[0m"
systemctl enable mysqld
systemctl start mysqld
echo $?

echo -e "\e[35m set the password for sql database \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1
echo $?
