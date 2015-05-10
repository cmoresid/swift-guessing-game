//
//  ViewModel.swift
//  GuessingGame
//
//  Created by Connor Moreside on 2015-05-10.
//  Copyright (c) 2015 Connor Moreside. All rights reserved.
//

import Foundation

protocol ViewModel {
    var message : Dynamic<String> { get }
    var buttonText : Dynamic<String> { get }
    var currentGuessesLabelText : Dynamic<String> { get }
    var guessFieldText : Dynamic<String> { get }
    var playAgain : Bool { set get }
    var currentState : Dynamic<GuessResult?> { get }
    
    func guessNumber(guess : String?)
}