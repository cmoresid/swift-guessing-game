//
//  ViewController.swift
//  GuessingGame
//
//  Created by Connor Moreside on 2015-05-10.
//  Copyright (c) 2015 Connor Moreside. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PropertyObserver {
    private var viewModel : GameViewModel!
    
    @IBOutlet var guessField : UITextField!
    @IBOutlet var guessButton : UIButton!
    @IBOutlet var guessLabel : UILabel!
    @IBOutlet var numberGuessLabel : UILabel!
    
    func willChangePropertyName(propertyName: String, newPropertyValue: AnyObject?) {
        switch propertyName {
            case "message": guessLabel.text = newPropertyValue as? String
            case "buttonLabel": guessButton.setTitle(newPropertyValue as? String, forState: UIControlState.Normal)
            case "currentGuesses": numberGuessLabel.text = String(newPropertyValue as! Int)
            case "guessField": guessField.text = newPropertyValue as? String
            
            default: return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = GameViewModel(delegate: self, lower: 0, upper: 20)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func guessNumber() {
        if (viewModel.currentState == GuessResult.Correct || viewModel.currentState == GuessResult.Lose) {
            viewModel.playAgain = true
            return
        }

        viewModel.guessNumber(guessField.text)
    }
}

