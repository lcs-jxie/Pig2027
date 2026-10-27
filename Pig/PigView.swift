//
//  PigView.swift
//  Pig
//
//  WHAT THIS GAME DOES NOW
//  Pig is a dice game for two players who share one laptop.
//  On your turn, roll the die as many times as you like.
//  Each roll adds to your turn total.
//  Roll a 1 and you lose your turn total, and your turn is over.
//  Click Hold to bank your turn total into your score and end your turn.
//
//  WHAT IT DOES NOT DO YET
//  Nobody can win! The scores just keep going up.
//  In the real game, the first player to reach 100 points wins.
//

import SwiftUI

// Each player has their own colour.
// TRY: Change these two colours. Try Color.purple, Color.green or Color.pink.
let playerOneColor: Color = Color.blue
let playerTwoColor: Color = Color.orange

// The game itself: what it remembers, what it shows on the screen,
// and what it does when you click a button.
struct PigView: View {

    // MARK: - Stored properties

    // Each @State variable is something the game remembers.
    // When one of them changes, the screen updates by itself.

    // The points each player has banked. Banked points are safe.
    @State var playerOneScore: Int = 0
    @State var playerTwoScore: Int = 0
    @State var playeroneSixStreak: Int = 0
    @State var playertwoSixStreak: Int = 0
    @State var winner: Int? = nil
    // The points collected so far on this turn.
    // They are not safe until the player clicks Hold.
    @State var turnTotal: Int = 0

    // Whose turn it is: 1 or 2.
    @State var currentPlayer: Int = 1

    // The colour of whoever's turn it is.
    @State var turnColor: Color = playerOneColor

    // The name of the SF Symbol that shows the die.
    @State var dieSymbol: String = "questionmark.square.fill"

    // A message that tells the players what just happened.
    @State var message: String = "Player 1 goes first. Click Roll to start."

    // MARK: - Computed properties

    var body: some View {
        VStack(spacing: 12) {

            // The title at the top of the screen.
            HStack {
                Image(systemName: "dice.fill")
                Text("Pig")
            }
            .font(.largeTitle)
            .bold()

            // The scoreboard: one card for each player.
            HStack(spacing: 16) {
                VStack {
                    Text("Player 1")
                        .font(.headline)
                    Text("\(playerOneScore)")
                        .font(.system(size: 48, weight: .bold))
                        .monospacedDigit()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(playerOneColor.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                VStack {
                    Text("Player 2")
                        .font(.headline)
                    Text("\(playerTwoScore)")
                        .font(.system(size: 48, weight: .bold))
                        .monospacedDigit()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(playerTwoColor.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            Spacer()

            // Whose turn is it?
            Text("Player \(currentPlayer), your turn")
                .font(.title)
                .bold()
                .foregroundStyle(turnColor)

            // The die.
            // TRY: Change the size of the die from 120 to something bigger or smaller.
            Image(systemName: dieSymbol)
                .font(.system(size: 120))
                .foregroundStyle(turnColor)

            Text("Turn total: \(turnTotal)")
                .font(.title2)
                .bold()
                .monospacedDigit()

            Text(message)
                .font(.headline)
                .foregroundStyle(Color.secondary)
                .multilineTextAlignment(.center)
                .frame(minHeight: 44)

            Spacer()

            // The two buttons a player uses on their turn.
            // The code inside the braces runs when that button is clicked.
            HStack(spacing: 16) {
                Button("Roll", systemImage: "dice") {
                    rollDie()
                }
                .buttonStyle(.borderedProminent)
                .disabled(winner != nil)
                Button("Hold", systemImage: "hand.raised.fill") {
                    hold()
                }
                .buttonStyle(.bordered)
                .disabled(winner != nil)
            }
            .font(.title2)
            .bold()
            .controlSize(.large)
            .tint(turnColor)

            Button("New Game") {
                startNewGame()
            }
        }
        .padding(32)
        .fontDesign(.rounded)
        // How big the game's window is on the Mac. It can be made taller or wider.
        .frame(minWidth: 480, minHeight: 680)
    }

    // MARK: - Functions

    // Rolls the die once for the current player.
    func rollDie() {

        // Pick a random whole number from 1 to 6, just like a real die.
        let roll: Int = Int.random(in: 1...6)

        // Show the matching die face. For a roll of 4, the symbol is "die.face.4.fill".
        dieSymbol = "die.face.\(roll).fill"
        if currentPlayer == 1 {
            playeroneSixStreak = roll == 6 ? playeroneSixStreak + 1 : 0
        } else {
            playertwoSixStreak = roll == 6 ? playertwoSixStreak + 1 : 0
        }
        let Streak = currentPlayer == 1 ? playeroneSixStreak : playertwoSixStreak
        if Streak == 3 {
            winner = currentPlayer
            message = "Player \(currentPlayer) wins with 3 consecutive 6s!"
            return
            
        }
        
    
        if roll == 1 {
            // A 1 wipes out the turn total and ends the turn.
            message = "Oh no, a 1! Player \(currentPlayer) loses \(turnTotal) points."
            turnTotal = 0
            switchPlayer()
        } else {
            // Any other roll is added to the turn total.
            turnTotal += roll
            // TRY: Change this message.
            message = "You rolled a \(roll). Roll again, or hold?"
        }
    }

    // Banks the turn total into the current player's score, then ends the turn.
    func hold() {
        if currentPlayer == 1 {
            playerOneScore += turnTotal
        } else {
            playerTwoScore += turnTotal
        }
        message = "Player \(currentPlayer) banked \(turnTotal) points."
        turnTotal = 0
        switchPlayer()
    }

    // Passes the turn to the other player.
    func switchPlayer() {
        if currentPlayer == 1 {
            playeroneSixStreak = 0
            currentPlayer = 2
            turnColor = playerTwoColor
        } else {
            playertwoSixStreak = 0
            currentPlayer = 1
            turnColor = playerOneColor
        }
    }

    // Sets everything back to the way it was at the start.
    func startNewGame() {
        playerOneScore = 0
        playerTwoScore = 0
        turnTotal = 0
        currentPlayer = 1
        turnColor = playerOneColor
        dieSymbol = "questionmark.square.fill"
        message = "Player 1 goes first. Click Roll to start."
        
        playeroneSixStreak = 0
        playertwoSixStreak = 0
        winner = nil
    }
}

#Preview {
    PigView()
}
