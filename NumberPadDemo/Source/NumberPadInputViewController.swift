//
//  NumberPadInputViewController.swift
//  NumberPadDemo
//
//  Created by Shawn Roller on 3/15/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//

import UIKit

protocol NumberPadDelegate: NSObjectProtocol {
    func numberPad(_ numberPad: NumberPadInputViewController, typed number: String)
    func tappedNext(numberPad: NumberPadInputViewController)
}

class NumberPadInputViewController: UIViewController {

    // MARK: Public properties
    public weak var delegate: NumberPadDelegate?
    public var cornerRadius: CGFloat = 0
    public var customButtonTitles = [String]()
    public var buttonBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    public var buttonTitleColor = #colorLiteral(red: 0.2744824886, green: 0.2745272219, blue: 0.2744727433, alpha: 1)
    public var buttonFont = UIFont(name: "Gotham-Medium", size: 26) ?? UIFont.systemFont(ofSize: 26)
    public var variableButtonFont = UIFont(name: "Gotham-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
    public var variableFontSizePositions = [9, 11]
    public var buttonBorderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    public var outsideBorderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    public var currentNumber = ""
    
    // MARK: Private properties
    fileprivate var buttonTitles: [String] {
        if self.customButtonTitles.count == 12 {
            return self.customButtonTitles
        }
        else {
            return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "NEXT", "0", "DEL"]
        }
    }
    
    // MARK: Outlets
    @IBOutlet var buttonViewCollection: [UIView]!
    @IBOutlet var buttonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }

}

// MARK: - Public
extension NumberPadInputViewController {
    
    public func reset() {
        currentNumber = ""
    }
    
}

// MARK: - Tappers
extension NumberPadInputViewController {
    
    @IBAction fileprivate func tappedButton(_ sender: UIButton) {
        guard let number = sender.currentTitle else { return }
        self.currentNumber += number
        self.delegate?.numberPad(self, typed: self.currentNumber)
    }
    
    @IBAction fileprivate func tappedNext( _sender: UIButton) {
        self.currentNumber = ""
        self.delegate?.tappedNext(numberPad: self)
    }
    
    @IBAction fileprivate func tappedDelete(_ sender: UIButton) {
        guard self.currentNumber.count > 0 else { return }
        var newNumber = ""
        if self.currentNumber.count > 1 {
            newNumber = String(self.currentNumber.prefix(self.currentNumber.count - 1))
        }
        self.currentNumber = newNumber
        self.delegate?.numberPad(self, typed: self.currentNumber)
    }
    
}

// MARK: - Private
extension NumberPadInputViewController {
    
    fileprivate func layoutView() {
        if self.cornerRadius > 0 {
            self.view.layer.masksToBounds = true
            self.view.layer.cornerRadius = self.cornerRadius
        }
        
        for (index, button) in buttonCollection.enumerated() {
            guard self.buttonTitles.count > index else { continue }
            button.setTitle(self.buttonTitles[index], for: .normal)
            button.backgroundColor = self.buttonBackgroundColor
            button.setTitleColor(buttonTitleColor, for: .normal)
            if variableFontSizePositions.contains(index) {
                button.titleLabel?.font = self.variableButtonFont
            }
            else {
                button.titleLabel?.font = self.buttonFont
            }
        }
        
        // Add Borders around the buttons
        for view in buttonViewCollection {
            view.layer.borderColor = self.buttonBorderColor.cgColor
            view.layer.borderWidth = 0.5
        }
        self.view.layer.borderColor = self.outsideBorderColor.cgColor
        self.view.layer.borderWidth = 1
    }
    
}
