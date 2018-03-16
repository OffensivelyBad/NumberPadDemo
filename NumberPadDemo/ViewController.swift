//
//  ViewController.swift
//  NumberPadDemo
//
//  Created by Shawn Roller on 3/15/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldOne: UITextField! // tag 101
    @IBOutlet weak var textFieldTwo: UITextField! // tag 102
    @IBOutlet weak var textFieldThree: UITextField! // tag 103
    @IBOutlet weak var numPadContainerView: UIView!
    
    fileprivate var numPad = NumberPadInputViewController()
    fileprivate var selectedTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the numberpad
        setupNumberPad()
        
        // Set the delegate on the textfields
        for textField in [self.textFieldOne, self.textFieldTwo, self.textFieldThree] {
            textField!.delegate = self
        }
    }
    
    fileprivate func setupNumberPad() {
        self.numPad = NumberPadInputViewController(nibName: "NumberPadInputViewController", bundle: nil)
        self.numPad.delegate = self
        self.numPad.view.frame = self.numPadContainerView.frame
        self.view.addSubview(self.numPad.view)
        self.numPad.didMove(toParentViewController: self)
    }

}

// MARK: - NumberPadDelegate
extension ViewController: NumberPadDelegate {
    
    func numberPad(_ numberPad: NumberPadInputViewController, typed number: String) {
        guard let textField = self.selectedTextField else { return }
        textField.text = number
    }
    
    func tappedNext(numberPad: NumberPadInputViewController) {
        guard let textField = self.selectedTextField else { return }
        
        var nextTag = 101
        switch textField.tag {
        case 101, 102:
            nextTag = textField.tag + 1
        default:
            ()
        }
        
        self.selectedTextField = self.view.viewWithTag(nextTag) as? UITextField ?? self.textFieldOne
        self.selectedTextField?.becomeFirstResponder()
    }
    
}

// MARk: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        self.selectedTextField = textField
        self.numPad.currentNumber = textField.text ?? ""
    }
    
}
