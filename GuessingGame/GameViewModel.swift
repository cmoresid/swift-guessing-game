//
//  GameViewModel.swift
//  GuessingGame
//
//  Created by Connor Moreside on 2015-05-10.
//  Copyright (c) 2015 Connor Moreside. All rights reserved.
//

import Foundation

class GameViewModel {
    weak var observer : PropertyObserver?
    
    private var game : Game!
    private var lower : UInt32!
    private var upper : UInt32!
    
    var currentState : GuessResult?
    
    var message : String = "" {
        willSet(newValue) {
            observer?.willChangePropertyName("message", newPropertyValue: newValue)
        }
    }
    
    var buttonLabel : String = "" {
        willSet(newValue) {
            observer?.willChangePropertyName("buttonLabel", newPropertyValue: newValue)
        }
    }
    
    var currentGuesses : Int = 0 {
        willSet(newValue) {
            observer?.willChangePropertyName("currentGuesses", newPropertyValue: newValue)
        }
    }
    
    var guessField : String = "" {
        willSet(newValue) {
            observer?.willChangePropertyName("guessField", newPropertyValue: newValue)
        }
    }
    
    var playAgain : Bool =  false {
        willSet(play) {
            if (play) {
                game = Game(lower: lower, upper: upper)
                buttonLabel = "Guess"
                guessField = ""
                message = "Please enter a number between \(lower) and \(upper)"
                currentGuesses = 0
                currentState = nil
            }
        }
    }
    
    init(delegate : PropertyObserver?, lower : UInt32, upper : UInt32) {
        self.lower = lower
        self.upper = upper
        self.observer = delegate
        
        game = Game(lower: lower, upper: upper)
        
        // Property listeners are not triggered directly in initializer.
        initLabels()
    }
    
    private func initLabels() {
        message = "Please enter a number between \(lower) and \(upper)"
        buttonLabel = "Guess"
        currentGuesses = 0
    }
    
    func guessNumber(guess : String?) {
        if let guessInt = guess?.toInt() {
            currentState = game.guessNumber(UInt32(guessInt))
            currentGuesses++
        }
        else {
            message = "Please enter a valid number."
            currentState = nil
            return
        }
        
        switch currentState {
            case .Some(.Lower):
                message = "Please guess lower number."
            case .Some(.Higher):
                message = "Please guess a higher number."
            case .Some(.Lose):
                message = "You lose!";
                buttonLabel = "Play again?";
                guessField = "";
                currentGuesses = 0
            case .Some(.Correct):
                message = "You are correct.";
                buttonLabel = "Play again?";
                guessField = "";
                currentGuesses = 0
            
            default: return
        }
    }
}
