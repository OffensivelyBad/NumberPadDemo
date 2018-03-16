//
//  ViewController.swift
//  NumberPadDemo
//
//  Created by Shawn Roller on 3/15/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//

import UIKit

extension UIView {
    func roundView(cornerRadius: CGFloat, shadow: Bool) {
        let layer = self.layer
        
        if cornerRadius > 0 {
            self.clipsToBounds = true
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
        }
        
        if shadow {
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 1.0
            layer.shadowOpacity = 0.35
            let roundedRect = CGRect(x: -1, y: 0, width: layer.bounds.width + 2, height: layer.bounds.height + 3)
            layer.shadowPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: layer.cornerRadius).cgPath
            
            let bgColor = self.backgroundColor?.cgColor
            self.backgroundColor = nil
            layer.backgroundColor = bgColor
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var textFieldOne: UITextField! // tag 101
    @IBOutlet weak var textFieldTwo: UITextField! // tag 102
    @IBOutlet weak var textFieldThree: UITextField! // tag 103
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var numPadContainerView: UIView!
    
    fileprivate var numPad = NumberPadInputViewController()
    fileprivate var selectedTextField: UITextField?
    fileprivate var cornerRadius: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate on the textfields
        for textField in self.textFields {
            textField.delegate = self
            textField.tintColor = .clear
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Round the containerView
        self.numPadContainerView.roundView(cornerRadius: self.cornerRadius, shadow: true)
        
        // Add the numberpad
        setupNumberPad()
    }
    
    fileprivate func setupNumberPad() {
        self.numPad = NumberPadInputViewController(nibName: "NumberPadInputViewController", bundle: nil)
        self.numPad.delegate = self
        self.numPad.outsideBorderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.numPad.buttonBorderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.numPad.buttonTitleColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.numPad.buttonBackgroundColor = #colorLiteral(red: 0.340957284, green: 0.5572940707, blue: 0.9015302062, alpha: 1)
        self.numPad.cornerRadius = self.cornerRadius
        self.numPad.view.frame = self.numPadContainerView.frame
        self.view.addSubview(self.numPad.view)
        self.numPad.didMove(toParentViewController: self)
    }
    
    fileprivate func setBordersForTextFields() {
        for textField in self.textFields {
            if textField == self.selectedTextField {
                textField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                textField.layer.borderWidth = 1
            }
            else {
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        }
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
        setBordersForTextFields()
    }
    
}
