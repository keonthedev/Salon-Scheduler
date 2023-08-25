#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"


echo "~~~~ SALON NAME ~~~~"


MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

# while above goes here
  echo -e "\nWelcome, how can I help you today?"
  APT_TYPES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  if [[ -z $APT_TYPES ]]
  then
   echo -e "\Sorry, we do not have that service today" 
  else
    echo "$APT_TYPES" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done
  fi 
  
  read MAIN_MENU_SELECTION
  case $MAIN_MENU_SELECTION in 
    1) HAIR_MENU ;;
    2) NAILS_MENU ;;
    3) SKIN_CARE ;;
    4) MAKE_UP ;;
    5) MASSAGE_MENU ;;
    6) EXIT ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}
HAIR_MENU () {
   
   echo -e "What is your phone number?"
    read PHONE_NUMBER
   while [[ ! $PHONE_NUMBER =~ ^[0-9]{3}-[0-9]{4}$ ]]
   do
      echo -e "what is your phone number?"
      read PHONE_NUMBER
  done
      MEMBER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$PHONE_NUMBER'")
   

   if [[ -z $MEMBER_NAME ]]
   then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read MEMBER_NAME
    NEW_MEMBER_NAME=$($PSQL "INSERT INTO customers(phone, name) VALUES('$PHONE_NUMBER', '$MEMBER_NAME')")
   fi
  MEMBER_FORMATTED=$(echo $MEMBER_NAME | sed 's/ |//')

  echo -e "\nWhat time would you like your appointment, $MEMBER_FORMATTED?"
    read APT_ANSWER

  while [[ ! $APT_ANSWER =~ ^(1[0-2]|0[0-9]):[0-5][0-9]$ ]]
  do  
  echo -e "\nPlease enter a time (example: 11:11)"
    read APT_ANSWER
  done

    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=1")
    CUSTOMERS_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$MEMBER_FORMATTED'")    

    SET_APT=$($PSQL "INSERT INTO appointments(time, service_id, customer_id) VALUES('$APT_ANSWER', $SERVICE_ID, $CUSTOMERS_ID)")
    echo -e "\nI have put you down for $APT_ANSWER, $MEMBER_FORMATTED."
  return

}


NAILS_MENU () {
 
  echo -e "What is your phone number?"
    read PHONE_NUMBER
   
   while [[ ! $PHONE_NUMBER =~ ^[0-9]{3}-[0-9]{4}$ ]]
   do
    echo -e "What is your phone number?"
      read PHONE_NUMBER     
    done
      MEMBER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$PHONE_NUMBER'")

   if [[ -z $MEMBER_NAME ]]
   then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read MEMBER_NAME
    NEW_MEMBER_NAME=$($PSQL "INSERT INTO customers(phone, name) VALUES('$PHONE_NUMBER', '$MEMBER_NAME')")
   fi
  MEMBER_FORMATTED=$(echo $MEMBER_NAME | sed 's/ |//')
  
  echo -e "\nWhat time would you like your appointment, $MEMBER_FORMATTED?"
    read APT_ANSWER
  # these are all integers

  while [[ ! $APT_ANSWER =~ ^(1[0-2]|0[0-9]):[0-5][0-9]$ ]]
  do
    echo -e "\nPlease enter a time (example: 11:11)"
    read APT_ANSWER
  done

    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=2")
    CUSTOMERS_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$MEMBER_FORMATTED'")    

    SET_APT=$($PSQL "INSERT INTO appointments(time, service_id, customer_id) VALUES('$APT_ANSWER', $SERVICE_ID, $CUSTOMERS_ID)")

  echo -e "\nI have put you down for $APT_ANSWER, $MEMBER_FORMATTED."
  return

}

# member should probably not be able to double book, this may solve why the program continues to loop

SKIN_CARE () {
  
  echo -e "What is your phone number?"
    read PHONE_NUMBER
   
   while [[ ! $PHONE_NUMBER =~ ^[0-9]{3}-[0-9]{4}$ ]]
   do
    echo -e "What is your phone number?"
    read PHONE_NUMBER
    done
      MEMBER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$PHONE_NUMBER'")

   if [[ -z $MEMBER_NAME ]]
   then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read MEMBER_NAME
    NEW_MEMBER_NAME=$($PSQL "INSERT INTO customers(phone, name) VALUES('$PHONE_NUMBER', '$MEMBER_NAME')")
   fi
  MEMBER_FORMATTED=$(echo $MEMBER_NAME | sed 's/ |//')

  echo -e "\nWhat time would you like your appointment, $MEMBER_FORMATTED?"
    read APT_ANSWER

  while [[ ! $APT_ANSWER =~ ^(1[0-2]|0[0-9]):[0-5][0-9]$ ]]
    do 
    echo -e  "\nPlease enter a time (example: 11:11)"
      read APT_ANSWER
    done

    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=3")
    CUSTOMERS_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$MEMBER_FORMATTED'")
    SET_APT=$($PSQL "INSERT INTO appointments(time, service_id, customer_id) VALUES('$APT_ANSWER', $SERVICE_ID, $CUSTOMERS_ID)")

  echo -e "\nI have put you down for $APT_ANSWER, $MEMBER_FORMATTED."
  return
    
  
}


MAKE_UP () {

  echo -e "What is your phone number?"
    read PHONE_NUMBER
    
   while [[ ! $PHONE_NUMBER =~ ^[0-9]{3}-[0-9]{4}$ ]]
   do
    echo -e "What is your phone number?"
    read PHONE_NUMBER
    done
      MEMBER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$PHONE_NUMBER'")

   if [[ -z $MEMBER_NAME ]]
   then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read MEMBER_NAME
    NEW_MEMBER_NAME=$($PSQL "INSERT INTO customers(phone, name) VALUES('$PHONE_NUMBER', '$MEMBER_NAME')")
   fi
  MEMBER_FORMATTED=$(echo $MEMBER_NAME | sed 's/ |//')
  echo -e "\nWhat time would you like your appointment, $MEMBER_FORMATTED?"
    read APT_ANSWER
  # these are all integers
  while [[ ! $APT_ANSWER =~ ^(1[0-2]|0[0-9]):[0-5][0-9]$ ]]
    do 
      echo -e "\nPlease enter a time (example: 11:11)"
      read APT_ANSWER
    done

    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=4")
    CUSTOMERS_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$MEMBER_FORMATTED'")
    SET_APT=$($PSQL "INSERT INTO appointments(time, service_id, customer_id) VALUES('$APT_ANSWER', $SERVICE_ID, $CUSTOMERS_ID)")

  echo -e "\nI have put you down for $APT_ANSWER, $MEMBER_FORMATTED."
  return
     
  
}


MASSAGE_MENU () {
  echo -e "What is your phone number?"
  read PHONE_NUMBER
   
   while [[ ! $PHONE_NUMBER =~ ^[0-9]{3}-[0-9]{4}$ ]]
   do
    echo -e "What is your phone number?"
    read PHONE_NUMBER
    done
      MEMBER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$PHONE_NUMBER'")

   if [[ -z $MEMBER_NAME ]]
   then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read MEMBER_NAME
    NEW_MEMBER_NAME=$($PSQL "INSERT INTO customers(phone, name) VALUES('$PHONE_NUMBER', '$MEMBER_NAME')")
   fi
  MEMBER_FORMATTED=$(echo $MEMBER_NAME | sed 's/ |//')
  echo -e "\nWhat time would you like your appointment, $MEMBER_FORMATTED?"
    read APT_ANSWER

  
  while [[ ! $APT_ANSWER =~ ^(1[0-2]|0[0-9]):[0-5][0-9]$ ]]
  do 
    echo -e "\nPlease enter a time (example: 11:11)"
    read APT_ANSWER
  done

    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=5")
    CUSTOMERS_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$MEMBER_FORMATTED'")
    SET_APT=$($PSQL "INSERT INTO appointments(time, service_id, customer_id) VALUES('$APT_ANSWER', $SERVICE_ID, $CUSTOMERS_ID)")

  echo -e "\nI have put you down for $APT_ANSWER, $MEMBER_FORMATTED."
  return
     
  
}
MAIN_MENU
