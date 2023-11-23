color="\e[36m"

echo -e "${color} Disable nodejs default version \e[0m"
dnf module disable nodejs -y &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Enable nodejs 18 version \e[0m"
dnf module enable nodejs:18 -y &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Install nodejs 18 version \e[0m"
dnf install nodejs -y &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Create backend service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Create user named expense for Application\e[0m"
useradd expense &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Create directory called app for Application \e[0m"
mkdir /app &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Download backend application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi
cd /app &>>/tmp/backend.log
echo -e "${color} Extract backend application content \e[0m"
unzip /tmp/backend.zip &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Download nodejs dependencies \e[0m"
npm install &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Install mysql client to load the Schema\e[0m"
dnf install mysql -y &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi
echo -e "${color} Load the schema \e[0m"
mysql -h mysql-dev.vijayavanimanju.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi

echo -e "${color} Start backend service \e[0m"
systemctl daemon-reload &>>/tmp/backend.log
systemctl enable backend &>>/tmp/backend.log
systemctl start backend &>>/tmp/backend.log
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCESS"
else
  echo -e "\e[31m FAILURE"
fi
