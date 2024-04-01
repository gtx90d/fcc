#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Add teams in "teams" table
cat games.csv | while IFS=',' read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if (( YEAR != year ))
  then
    if [ $(echo $($PSQL "SELECT EXISTS(SELECT 1 FROM teams WHERE name='$WINNER')")) = "f" ]
    then
      echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    fi
    if [ $(echo $($PSQL "SELECT EXISTS(SELECT 1 FROM teams WHERE name='$OPPONENT')")) = "f" ]
    then
      echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    fi
  fi
done

# Add games in "games" table and assign winner_id and opponent_id based on the key
cat games.csv | while IFS=',' read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if (( YEAR != year ))
  then
    WINNER_ID=$(echo $($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'"))
    OPPONENT_ID=$(echo $($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'"))
    echo $($PSQL "
      INSERT INTO games(
        year, round, winner_id, opponent_id, winner_goals, opponent_goals
      )
      VALUES(
        $YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS
      )
    ")
  fi
done