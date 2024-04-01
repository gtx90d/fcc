#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

# Create "teams" and "games" tables
#echo $($PSQL "DROP TABLE games, teams");

echo $($PSQL "
  CREATE TABLE teams(
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL UNIQUE
  )
");

echo $($PSQL "
  CREATE TABLE games(
    game_id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    round VARCHAR(24) NOT NULL,
    winner_id INT NOT NULL REFERENCES teams(team_id),
    opponent_id INT NOT NULL REFERENCES teams(team_id),
    winner_goals INT NOT NULL,
    opponent_goals INT NOT NULL
  );
");

# Empty all rows from the tables ("teams" and "games")
echo $($PSQL "TRUNCATE TABLE teams, games");