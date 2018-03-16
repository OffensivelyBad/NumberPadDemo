//
//  ViewController.swift
//  NumberPadDemo
//
//  Created by Shawn Roller on 3/15/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var textFieldTwo: UITextField!
    @IBOutlet weak var textFieldThree: UITextField!
    @IBOutlet weak var numPadContainerView: UIView!
    
    fileprivate var numPad = NumberPadInputViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the numberpad
        setupNumberPad()
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
        
    }
    
    func tappedNext(numberPad: NumberPadInputViewController) {
        
    }
    
}

