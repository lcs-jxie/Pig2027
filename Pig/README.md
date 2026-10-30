# Pig

A simple dice-rolling game where you race against the computer to reach 100 points. Roll as many times as you like to build up points, but roll a 1 and you lose all points for that turn!

## How to play

Two players take turns playing Pig on the same computer.

1. Player 1 goes first. Click **Roll** to roll the die.
2. If you roll a 2 through 6, that number is added to your turn total. You can roll again or click **Hold**.
3. If you roll a 1, your turn total is lost and your turn ends.
4. Click **Hold** to add your turn total to your score and pass the turn to the other player.
5. The first player to reach 100 points wins.
6. There is also a hidden way to win: roll three 6s in a row during the same turn.
7. Click **New Game** to reset the scores and start again.


## What I added

1.I added a hidden win condition to the original Pig dice game: a player wins immediately by rolling three 6s in a row during the same turn. The program tracks each player’s consecutive 6s and resets the count when they roll another number or their turn ends.
2.I also added a hidden win condition: a player wins immediately by rolling three 6s in a row during the same turn.

## Credits

- The starting game was written by Mr. Gordon.
- ChatGPT helped me understand the code.

## How it works

The game uses `playeroneSixStreak` and `playertwoSixStreak` to count each player's consecutive rolls of 6 during their turn. They are `Int` variables because the counts are whole numbers that can change. An `if` and `else` decision checks the roll: if it is 6, the current player's count increases by 1; otherwise, the count resets to 0. The `streak` constant holds the current player's count for that roll. The game calls `hasThreeSixes(streak:)` to check whether the count is 3. I chose three 6s to make a surprising hidden way to win. The rule is hidden during play so players can discover it.

The game also checks for the original 100-point win condition when a player clicks `Hold`. The player's turn total is added to their score, and an `if` and `else if` decision checks whether that score is 100 or more. If it is, the game stores that player's number in `winner` and displays a win message. I kept this rule so the game still has its original way to win.

## Testing-hidden win condition

1.Three 6s in a row (edge) Fix every roll at 6; Player 1 clicks Roll three times. Player 1 wins with 3 consecutive 6s. Roll and Hold turn off.
"let roll: Int = 6"

Result: Player 1 won after three 6s, as expected.

2.Two 6s, one short (edge) Fix every roll at 6; Player 1 clicks Roll twice. Nobody wins yet. Roll and Hold remain available.

Result: Nobody won after two 6s, as expected.

3.The run ends with the turn. Fix every roll at 6; Player 1 clicks Roll twice, then Hold; Player 2 clicks Hold; Player 1 clicks Roll once. Player 1's previous two 6s do not count. Player 1 has only one 6 in the new turn, so nobody wins.

Result: The streak reset when the turn ended, as expected.
 
4.After a win. Follow the first test, then click Roll and Hold. Roll and Hold stay disabled after Player 1 wins.

Result: Roll and Hold were disabled after the win, as expected.

5.New Game after a win. Follow the first test, then click New Game, then click Roll. The game resets, Player 1 starts again, and Roll works.

Results: New Game reset the game, as expected.

## Testing-100points

1.Reach 100 points. Set Player 1's score to 94 for testing. Fix every roll at 6; Player 1 clicks Roll once, then Hold. Player 1's score reaches 100, so Player 1 wins.

Result: Player 1 won after reaching 100 points, as expected.

2.One point short of 100. Set Player 1's score to 93 for testing. Fix every roll at 6; Player 1 clicks Roll once, then Hold. Player 1's score reaches 99, so nobody wins yet.

Result: Nobody won at 99 points, as expected.
