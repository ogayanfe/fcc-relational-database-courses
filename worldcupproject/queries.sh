#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals)+SUM(opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT round(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT avg(winner_goals+opponent_goals)  FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT max(winner_goals) from games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "select count(*) from games where winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "select name from games left join teams on  teams.team_id = games.winner_id where year = 2018 and round = 'Final' ")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name FROM games LEFT JOIN teams ON games.winner_id = teams.team_id WHERE round='Eighth-Final' AND year=2014 UNION SELECT name FROM games LEFT JOIN teams ON games.opponent_id = teams.team_id WHERE round='Eighth-Final' AND year=2014 ORDER BY name ASC")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "select distinct(teams.name) from games inner join teams on teams.team_id = games.winner_id order by teams.name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "select year, name from games left join teams on games.winner_id = teams.team_id where round='Final' order by name desc")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "select name from teams where name like 'Co%' ")"
