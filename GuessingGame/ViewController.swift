//
//  ViewController.swift
//  GuessingGame
//
//  Created by Connor Moreside on 2015-05-10.
//  Copyright (c) 2015 Connor Moreside. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var guessField : UITextField!
    @IBOutlet var guessButton : UIButton!
    @IBOutlet var guessLabel : UILabel!
    @IBOutlet var numberGuessLabel : UILabel!
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.buttonText.bindAndFire {
                [unowned self] in
                self.guessButton.setTitle($0, forState: UIControlState.Normal)
            }
            
            viewModel.currentGuessesLabelText.bindAndFire {
                [unowned self] in
                self.numberGuessLabel.text = $0
            }
            
            viewModel.guessFieldText.bindAndFire {
                [unowned self] in
                self.guessField.text = $0
            }
            
            viewModel.message.bindAndFire {
                [unowned self] in
                self.guessLabel.text = $0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = GameViewModel(lower: 0, upper: 20)
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

