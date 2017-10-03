//
//  ViewController.swift
//  ValidationsDemo
//
//  Created by Monu on 15/09/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var requiredTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var alphaNumericTextField: UITextField!
    @IBOutlet weak var wordFilterTextField: UITextField!
    @IBOutlet weak var wordFilterThoroughTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //-- Apply validations
        applyValidations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        if checkValidation() {
            print("Success")
        }
    }

}

extension ViewController {
    
    fileprivate func applyValidations(){
        fullNameTextField.validations = [Validation.letter(message: "Full name can only allow alphabetic characters.")]
        emailTextField.validations = [Validation.email(message: "Invalid email address")]
        mobileTextField.validations = [Validation.mobile(message: "Invalid mobile number")]
        passwordTextField.validations = [Validation.password(message: "Invalid password")]
        requiredTextField.validations = [Validation.required(message: "Text field is required")]
        ageTextField.validations = [Validation.range(min: 18, max: 70, message: "Invalid age value")]
        alphaNumericTextField.validations = [Validation.alphaNumeric(message: "Invalid alphanumeric textfield value")]
        wordFilterTextField.validations = [Validation.filterMessageBase(message: "Sorry these words are not allowed")]
        wordFilterThoroughTextField.validations = [Validation.filterMessageExhaustive(message: "Sorry these words are not allowed")]
    }
    
    fileprivate func checkValidation() -> Bool{
        do {
            try fullNameTextField.validate()
            try emailTextField.validate()
            try mobileTextField.validate()
            try passwordTextField.validate()
            try requiredTextField.validate()
            try ageTextField.validate()
            try alphaNumericTextField.validate()
            try wordFilterTextField.validate()
            try wordFilterThoroughTextField.validate()
            return true
        }
        catch{
            print(error.localizedDescription)
            return false
        }
    }
}

