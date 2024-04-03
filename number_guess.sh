#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

USERNAME='';
SECRET_NUMBER=$((1 + $RANDOM % 1000))
NUMBER_OF_GUESSES=1

LOGIN() {
  USERNAME=$1
  GET_LOGIN=$($PSQL "SELECT COUNT(*) FROM users WHERE username = '$USERNAME'");
  if (( $GET_LOGIN ==  0 )); then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    echo $($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")  > /dev/null
  elif (( $GET_LOGIN == 1 )); then
    DATA=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username = '$USERNAME'")
    echo $DATA | while read u BAR GAMES_PLAYED BAR BEST_GAME; do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    done
  fi
  GAME
}

GAME() {
  if [[ -z $1 ]]; then
    echo "Guess the secret number between 1 and 1000:"  
  fi
  read INPUT_NUMBER
  # add integer checking
  if ! [[ $INPUT_NUMBER =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    GAME 0
  fi
  if (( $SECRET_NUMBER == $INPUT_NUMBER )); then
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    CURRENT_BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'")
    if (( $CURRENT_BEST_GAME > $NUMBER_OF_GUESSES || $CURRENT_BEST_GAME == 0 )); then
      echo $($PSQL "
        UPDATE users
        SET
          best_game = $NUMBER_OF_GUESSES,
          games_played = games_played + 1
        WHERE username = '$USERNAME'
      ") > /dev/null
    fi
  else
    if (( $SECRET_NUMBER > $INPUT_NUMBER )); then
      echo "It's higher than that, guess again:"
    elif (( $SECRET_NUMBER < $INPUT_NUMBER )); then   
      echo "It's lower than that, guess again:"
    fi
    NUMBER_OF_GUESSES=$(($NUMBER_OF_GUESSES + 1))
    GAME 0
  fi
}

echo "Enter your username: "
read USERNAME
if ! [[ -z $USERNAME ]]
then
  LOGIN $USERNAME
fi
