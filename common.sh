color="\e[36m"
log_file=/tmp/expense.log
blue="\e[34m"

status_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS"
  else
    echo -e "\e[31m FAILURE"
  fi
}