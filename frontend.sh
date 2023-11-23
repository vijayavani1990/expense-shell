log_file=/tmp/expense.log
blue="\e[34m"

echo -e "${blue} Installing Nginx \e[0m"
dnf install nginx -y &>>$log_file

echo -e "${blue} Copy Expense Config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file

echo -e "${blue} Clean Old Nginx file \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file

echo -e "${blue} Download Frontend application code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log

echo -e "${blue} Extract the downloaded frontend code \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file

echo -e "${blue} Restart Nginx service \e[0m"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
