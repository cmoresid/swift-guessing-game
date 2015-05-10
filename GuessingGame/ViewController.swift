//
//  ViewController.swift
//  GuessingGame
//
//  Created by Connor Moreside on 2015-05-10.
//  Copyright (c) 2015 Connor Moreside. All rights reserved.
//

import UIKit
import Bond

class ViewController: UIViewController {
    private var viewModel : GameViewModel!
    
    @IBOutlet var guessField : UITextField!
    @IBOutlet var guessButton : UIButton!
    @IBOutlet var guessLabel : UILabel!
    @IBOutlet var numberGuessLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = GameViewModel(lower: 1, upper: 20)
        
        viewModel.buttonText ->> self.guessButton.dynTitle
        viewModel.currentGuessesLabelText ->> self.numberGuessLabel.dynText
        viewModel.guessFieldText ->> self.guessField.dynText
        viewModel.message ->> self.guessLabel.dynText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func guessNumber() {
        if (viewModel.currentState.value == GuessResult.Correct ||
            viewModel.currentState.value == GuessResult.Lose) {
                
            viewModel.playAgain = true
            return
        }

        viewModel.guessNumber(guessField.text)
    }
}

