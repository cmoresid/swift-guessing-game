//
//  Game.swift
//  GuessingGame
//
//  Created by Connor Moreside on 2015-05-10.
//  Copyright (c) 2015 Connor Moreside. All rights reserved.
//

import Foundation

enum GuessResult {
    case Lower, Higher, Correct, Lose
}

class Game {
    private var targetNumber : UInt32 = 0;
    private var maxGuesses : Int = 5
    
    var currentGuesses : Int = 0
    
    init(lower : UInt32, upper : UInt32) {
        targetNumber = arc4random_uniform(upper) + lower;
    }
    
    func guessNumber(guess : UInt32) -> GuessResult {
        if (guess < targetNumber) {
            currentGuesses++
            
            return (currentGuesses > maxGuesses) ?
                GuessResult.Lose : GuessResult.Higher
        }
        else if (guess > targetNumber) {
            currentGuesses++
            
            return (currentGuesses > maxGuesses) ?
                GuessResult.Lose : GuessResult.Lower
        }
        else {
            return GuessResult.Correct
        }
    }
}

