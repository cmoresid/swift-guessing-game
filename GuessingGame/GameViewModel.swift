//
//  GameViewModel.swift
//  GuessingGame
//
//  Created by Connor Moreside on 2015-05-10.
//  Copyright (c) 2015 Connor Moreside. All rights reserved.
//

import Foundation

class GameViewModel : ViewModel {
    private var game : Game
    private var lower : UInt32
    private var upper : UInt32
    
    var currentState : Dynamic<GuessResult?>
    
    let message : Dynamic<String>
    let buttonText : Dynamic<String>
    let currentGuessesLabelText : Dynamic<String>
    let guessFieldText : Dynamic<String>
    
    var playAgain : Bool =  false {
        willSet(play) {
            if (play) {
                game = Game(lower: lower, upper: upper)
                buttonText.value = "Guess"
                currentGuessesLabelText.value = ""
                message.value = "Please enter a number between \(lower) and \(upper)"
                currentState.value = nil
            }
        }
    }
    
    init(lower : UInt32, upper : UInt32) {
        self.lower = lower
        self.upper = upper
        
        game = Game(lower: lower, upper: upper)
        
        message = Dynamic("Please enter a number between \(lower) and \(upper)")
        buttonText = Dynamic("Guess")
        currentGuessesLabelText = Dynamic("")
        guessFieldText = Dynamic("")
        currentState = Dynamic(nil)
    }
    
    func guessNumber(guess : String?) {
        if let guessInt = guess?.toInt() {
            currentState.value = game.guessNumber(UInt32(guessInt))
            
            if let numberOfGuesses = currentGuessesLabelText.value.toInt() {
                currentGuessesLabelText.value = String(numberOfGuesses + 1)
            }
            else {
                currentGuessesLabelText.value = String(1)
            }
            
        }
        else {
            message.value = "Please enter a valid number."
            currentState.value = nil
            return
        }
        
        switch currentState.value {
            case .Some(.Lower):
                message.value = "Please guess lower number."
            case .Some(.Higher):
                message.value = "Please guess a higher number."
            case .Some(.Lose):
                message.value = "You lose!";
                buttonText.value = "Play again?";
                guessFieldText.value = "";
                currentGuessesLabelText.value = ""
            case .Some(.Correct):
                message.value = "You are correct.";
                buttonText.value = "Play again?";
                guessFieldText.value = "";
                currentGuessesLabelText.value = ""
            
            default: return
        }
    }
}
