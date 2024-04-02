#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  # check if there's an argument (in case the customers gets sent back to the main menu)
  if ! [ -z "$1" ]
  then
    # print the message and proceed
    echo -e "\n$1"
  else
    # otherwise, print the main message
    echo -e "\nWelcome to our salon's appointment booking service.\nHow can I help you?"
    # get the list of services and the number of services available
    SERVICES_LIST=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
    SERVICES_COUNT=$($PSQL "SELECT COUNT(service_id) FROM services")
  fi
  # start looping through the list of services
  echo "$SERVICES_LIST" | while read SERVICE_ID BAR SERVICE_NAME
  do
    # print them
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  # print also a final option (services list length + 1) to exit the program
  echo -e "$(($SERVICES_COUNT + 1)))  -- exit\n"
  # read the selected option
  read SERVICE_ID_SELECTED
  # check if the selected option is NOT between 1 and N (= number of services) + 1 (to add exit) - OR if the option is not a number
  if  ! ((  $SERVICE_ID_SELECTED >= 1 && $SERVICE_ID_SELECTED <= ($SERVICES_COUNT + 1))) || ! [[ $SERVICE_ID_SELECTED =~ ^[0-9]$ ]]
  then
    # in that case, print an error and send the customer back to the main menu
    MAIN_MENU "Invalid option. Please select one of the following options:"
  else
    # check if the selected option is "exit" (last one)
    if (( $SERVICE_ID_SELECTED == ($SERVICES_COUNT + 1)))
    then
      # in that case, print a message
      echo -e "\nSee you next time. Have a nice day"
    else
      # otherwise, if it's any other option, send to the booking menu
      BOOKING_MENU $SERVICE_ID_SELECTED
    fi
  fi
}

BOOKING_MENU() {
  # assign the first argument to SERVICE_ID_SELECTED
  SERVICE_ID_SELECTED=$1
  # prompt the customer for his/her phone number
  echo -e "\nWhat's your phone number?"
  # read the input
  read CUSTOMER_PHONE
  # check if the input number is already in the database
  R_CHECK_PHONE_NUMBER=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # if it's not in the database
  if [ -z $R_CHECK_PHONE_NUMBER ]
  then
    # prompt the customer for his/her name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    # read the input
    read CUSTOMER_NAME
  else
    # otherwise, if it the phone is already in the database, get the name associated with that number
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  fi
  # send the customer to the "time selection" part of the booking, passing the infos as arguments
  BOOKING_MENU_TIME $SERVICE_ID_SELECTED $CUSTOMER_PHONE $CUSTOMER_NAME
}

BOOKING_MENU_TIME() {
  # assign the arguments to variables
  SERVICE_ID_SELECTED=$1
  CUSTOMER_PHONE=$2
  CUSTOMER_NAME=$3
  # get the selected service's name and trim it (remove blankspaces from left and right)
  SERVICE_NAME=$( echo "$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")" | xargs )
  # prompt the customer for the time he/she wants to book the appointment at
  echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  # get the customer's id, if already in the database (he/her hasn't been added to the database yet)
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # if the customer's id doesn't exist yet
  if [ -z $CUSTOMER_ID ]
  then
    # insert the customer's data in the database 
    echo $($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')") > /dev/null
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  fi
  # then insert the appointment in the database with all the data
  echo $( $PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')") > /dev/null
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME." 
}


ADMIN_LOGIN() {
  echo -e "\nSalon Admin Panel"
  # prompt the admin for his/her username and password
  read -p "username: " -r USERNAME
  read -p "password: " -r -s PASSWORD
  
  # check if the username and password entered match any row in the database
  VALID_LOGIN=$($PSQL "
    SELECT count(*) AS match
    FROM admins
    WHERE
      username = '$USERNAME'
      AND
      password = crypt('$PASSWORD', password)
  ")
  
  # if there's no match, the command will return 0
  if (( $VALID_LOGIN == 0 ))
  then
    # in that case print an error message
    echo -e "\n\nLogin failed"
  else
    # otherwise show the appointments' list and pass the admin's username as argument
    SHOW_APPOINTMENTS $USERNAME
  fi
  # 
}


SHOW_APPOINTMENTS() {
  # assign the argument to USERNAME
  USERNAME=$1
  echo -e "\nWelcome $USERNAME, here's the appointments list:\n"
  # show the appointments' list
  echo "$($PSQL "
      SELECT
        time,
        services.name AS service,
        customers.name AS customer,
        phone
      FROM appointments
      INNER JOIN customers
        USING(customer_id)
      INNER JOIN services
      USING(service_id)
      ORDER BY time
    ")" | while read TIME BAR SERVICE BAR CUSTOMER BAR NUMBER
  do
    echo -e "$TIME \t $SERVICE \t $CUSTOMER \t $NUMBER"
  done
}


# start of the program: check if there are no arguments, OR if the argument is not "admin"
if [[ -z $1 ]] || [[ $1 != "admin" ]]
then
  # in that case send the customer to the main menu
  MAIN_MENU
else
  # otherwise send him/her to the admin login
  ADMIN_LOGIN
fi