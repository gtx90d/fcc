#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

GET_ELEMENT() {
  ELEMENT=$1
  RESULT=999
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    IS_NUMBER=true
    RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $ELEMENT")
  else
    IS_NUMBER=false
    RESULT=$($PSQL "SELECT * FROM elements WHERE symbol ILIKE '$ELEMENT' OR name ILIKE '$ELEMENT'")
  fi
  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    if $IS_NUMBER
    then
      echo $($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements
  INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $ELEMENT") | while read AN BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
      do
        echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    else
      echo $($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements
INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol ILIKE '$ELEMENT' or name ILIKE '$ELEMENT'") | while read AN BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
    do
      echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
    fi
  fi
}

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  GET_ELEMENT $1
fi 
