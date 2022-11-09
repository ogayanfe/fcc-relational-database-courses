#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

$PSQL "truncate teams, games"


# Script to automate adding data into world cup database.

while IFS=',' read year round winner opponent winner_goals opponent_goals 
  do

    winner_id=$($PSQL "select team_id from teams where name = '$winner'")
    
    if [[ $year != "year" ]]
      then 
        if [[ -z $winner_id ]]
          then
            $PSQL "insert into teams(name) values ('$winner')"
            echo "Inserting a new team into teams with name $winner"
            winner_id=$($PSQL "select team_id from teams where name = '$winner'")
        winner_id=$($PSQL "select team_id from teams where name = '$winner'")
        fi

        opponent_id=$($PSQL "select team_id from teams where name = '$opponent'")
        if [[ -z $opponent_id ]]
          then
          # echo "Hello World"
            $PSQL "insert into teams(name) values ('$opponent')"
            echo "Inserting a new opponent into teams with name $opponent"
            opponent_id=$($PSQL "select team_id from teams where name = '$opponent'")
        fi

        $PSQL "Insert into games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) values($year, $winner_id, $opponent_id, $winner_goals, $opponent_goals, '$round')"

    fi
  done < games.csv