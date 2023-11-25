color="\e[36m"

status_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCESS"
  else
    echo -e "\e[31m FAILURE"
  fi
}