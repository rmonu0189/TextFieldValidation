//
//  TextFieldValidation.swift
//  TextField Validations
//
//  Created by Monu on 15/09/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import Foundation
import UIKit

private var validationKey: UInt8 = 0
private var wordsForFilter = [String]()

internal extension UITextField {
    
    // Apply validations on current textfields.
    var validations: [Validation] {
        get {
            if let validations = objc_getAssociatedObject(self, &validationKey) as? [Validation] {
                return validations
            } else {
                return []
            }
        }
        
        set {
            objc_setAssociatedObject(self, &validationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // check if text field is empty
    func isEmpty() -> Bool{
        guard let string = self.text else {
            return true
        }
        let whitespaceSet = CharacterSet.whitespaces
        return string.trimmingCharacters(in: whitespaceSet).isEmpty
    }
    
    //MARK: Validation method
    func validate() throws {
        do{
            for validation in validations {
                switch validation {
                case let .required(message):
                    try requiredValidation(message: message)
                    
                case let .letter(message):
                    try letterValidation(message: message)
                    
                case let .maxLength(value, message):
                    try maxLengthValidation(length: value, message: message)
                    
                case let .minLength(value, message):
                    try minLengthValidation(length: value, message: message)
                    
                case let .email(message):
                    try emailValidation(message: message)
                    
                case let .mobile(message):
                    try mobileNumberValidation(message: message)
                    
                case let .password(message):
                    try passwordValidation(message: message)
                    
                case let .characterRange(min, max, message):
                    try characterRangeValidation(min: min, max: max, message: message)
                    
                case let .alphaNumeric(message):
                    try alphaNumericValidation(message: message)
                    
                case let .range(min, max, message):
                    try rangeValidation(min: min, max: max, message: message)
                    
                case let .filterWords(message):
                    try wordFilteredValidation(message: message)
                }
            }
        }
        catch {
            throw error
        }
    }
    
    //MARK: Private methods
    private func requiredValidation(message: String) throws {
        guard let value = text, !value.isEmpty else {
            throw generateException(message)
        }
    }
    
    private func letterValidation(message: String) throws {
        if let value = text, !value.isEmpty {
            if !(value.range(of: ValidationPreferences.letterRegEx, options: .regularExpression) == nil) {
                throw generateException(message)
            }
        }
    }
    
    private func maxLengthValidation(length:Int, message: String) throws {
        if let value = text, value.characters.count > length , !value.isEmpty{
            throw generateException(message)
        }
    }
    
    private func minLengthValidation(length:Int, message: String) throws {
        if let value = text, value.characters.count < length , !value.isEmpty{
            throw generateException(message)
        }
    }
    
    private func alphaNumericValidation(message: String) throws {
        if let value = text, !value.isEmpty {
            if !(value.range(of: ValidationPreferences.alphaNumericRegEx, options: .regularExpression) == nil) {
                throw generateException(message)
            }
        }
    }
    
    private func numericValidation(message: String) throws {
        if let value = text, !value.isEmpty {
            if !(value.range(of: ValidationPreferences.numericRegEx, options: .regularExpression) == nil) {
                throw generateException(message)
            }
        }
    }
    
    private func emailValidation(message: String) throws {
        if let value = text, !value.isEmpty {
            let emailTest = NSPredicate(format: "SELF MATCHES %@", ValidationPreferences.emailRegEx)
            if !emailTest.evaluate(with: value) {
                throw generateException(message)
            }
        }
    }
    
    private func mobileNumberValidation(message: String) throws {
        if let value = text, !value.isEmpty {
            if !(value.range(of: ValidationPreferences.numericRegEx, options: .regularExpression) == nil) || value.characters.count != 10 {
                throw generateException(message)
            }
        }
    }
    
    private func passwordValidation(message: String) throws {
        if let string = text, !string.isEmpty {
            if !NSPredicate(format: "SELF MATCHES %@", ValidationPreferences.passwordRegEx).evaluate(with: string) || isEmpty() {
                throw generateException(message)
            }
        }
    }
    
    private func characterRangeValidation(min:Int, max:Int, message: String) throws {
        if let string = text, !(string.characters.count >= min && string.characters.count <= max), !string.isEmpty {
            throw generateException(message)
        }
    }

    private func rangeValidation(min:Int, max:Int, message: String) throws {
        if let string = text, !string.isEmpty {
            guard let numeric = Int(string) else {
                throw generateException(message)
            }
            
            if !(numeric >= min && numeric <= max) {
                throw generateException(message)
            }
        }
    }
    
    private func wordFilteredValidation(message: String) throws {
        let wordsInText = text?.split(separator:" ");
        for word in wordsInText! {
            if wordsForFilter.contains(String(word)){
                throw generateException(message);
            }
        }
    }
    
    // Generate error from validations
    private func generateException(_ message: String) -> Error {
        return NSError(domain: ValidationPreferences.domain, code: ValidationPreferences.errorCode, userInfo: [NSLocalizedDescriptionKey: message, "textField":self]) as Error
    }
    
}
