//
//  ViewController.swift
//  TicTacToe
//
//  Created by Noy Hillel on 29/09/2016.
//  Copyright © 2016 Inscriptio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
        * Really basic Tic-Tac-Toe game, created by NoyH, all code updated from previous versions of Xcode and Swift.
        * The story board was re-made too, this time looking cleaner than before. Won't support all device sizes, set it onlu for iPhone 6 and above.
        * iPad intergration is possible, just won't look as clean. Didn't put too much effort into making it graphical on all devices in this project, back then, there were less devices to worry about lol.
     */
    
    // Winner label outlet
    @IBOutlet var winnerLabel: UILabel!
    // Play again button outlet
    @IBOutlet var playAgainButton: UIButton!
    
    // 1 is noughts, 2 is crosses
    var activePlayer = 1
    // This is to track how many turns have been done, to check if the game is a draw
    var turnCount = 0
    // Our game is defaulting to true, as it starts by default
    var activeGame = true
    // Our default gameState
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 - empty, 1 - noughts, 2 - crosses
    
    // These are all the winnable positions on the board
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    // Action for when pressing anywhere in the board, either an o or an x
    @IBAction func buttonPressed(_ sender: AnyObject) {
        // Variable for the active position, which is the sender's tag - 1
        let activePosition = sender.tag - 1
        // Checking if there is nothing placed, and the game is active
        if gameState[activePosition] == 0  && activeGame {
            // Set the active position, within the gameState as either x or o, (player 1 or 2)
            gameState[activePosition] = activePlayer
            // If it's the o
            if activePlayer == 1 {
                // Setting the image to nought, and specifying an empty array
                sender.setImage(UIImage(named: "nought.png"), for: [])
                // Everytime they press, increment our turnCount variable
                turnCount += 1
                // Set player to cross
                activePlayer = 2
            } else {
                // Setting the image to cross, and specifying an empty array
                sender.setImage(UIImage(named: "cross.png"), for: [])
                // Again, increment it by 1
                turnCount += 1
                // Set to nought
                activePlayer = 1
            }
            // This is to check all the winning combinations
            for combination in winningCombinations {
                // If the amount of turns has been 9, we want the game to know it's a draw
                if turnCount == 9 {
                    // Stop the game
                    activeGame = false
                    // Elements aren't hidden anymore
                    winnerLabel.isHidden = false
                    playAgainButton.isHidden = false
                    // Set the label to a draw
                    winnerLabel.text = "Draw!"
                    // Reset the counter, otherwise it will just keep incrementing
                    turnCount = 0
                    // Animate the elements,
                    self.animateElements()
                }
                // This checks if all the possible combinations are made, except for a draw.
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                    // This means, if there's definately a winner..
                    // Finish the game
                    activeGame = false
                    // Re-show the hidden items
                    winnerLabel.isHidden = false
                    playAgainButton.isHidden = false
                    // Checks if the o's was within the combination
                    if gameState[combination[0]] == 1 {
                        // Set noughts is the winner
                        winnerLabel.text = "Noughts has won!"
                        // Again, reset the count
                        turnCount = 0
                    } else {
                        // Same with this, just the cross is the winner
                        winnerLabel.text = "Crosses has won!"
                        turnCount = 0
                    }
                    // Animate the elements
                    self.animateElements()
                }
            }
        }
    }
    
    // Animating the elements, an internal (private) method.
    internal func animateElements() {
        // Animate the user interface within one second and the following animations..
        UIView.animate(withDuration: 1, animations: {
            // Move the winner label back to the center or 500 pixels back, from where we dissappeared it
            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
            // Same thing, just with the playAgainButton
            self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
        })
    }
    
    // Action for the play again button
    @IBAction func playAgain(_ sender: AnyObject) {
        // Restart the game
        activeGame = true
        // Make the player noughts
        activePlayer = 1
        // Reset the gameState
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        // Repmove all the noughts and crosses
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton { // optional casting
                button.setImage(nil, for: []) // sets images to nothing
            }
            self.dissapear()
        }
    }
    
    // Our dissapear method, making the elements dissapear
    internal func dissapear() {
        // Hide both the winner label and the button
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        // Remove the winner label and the button 500 pixels away from the screen, using our 'x' and 'y' co-ordinates locations
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
    }
    
    // Utils
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Gets rid of the elements not supposed to be there.
        self.dissapear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

