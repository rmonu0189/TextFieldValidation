//
//  ValidationPreferences.swift
//  TextField Validations
//
//  Created by Monu on 15/09/17.
//  Copyright © 2017 Appster. All rights reserved.
//

enum Validation {
    case required(message: String)               // String is required or not empty
    case letter(message: String)                 // Only allowed A-Z lower or upper case and blank space.
    case maxLength(value: Int, message: String)  // Maximum string length
    case minLength(value: Int, message: String)  // Minimum string length
    case email(message: String)
    case mobile(message: String)
    case password(message: String)
    case characterRange(min:Int, max:Int, message: String)
    case alphaNumeric(message: String)            // Only allowed A-Z lower or upper case or blank space or numeric values.
    case range(min:Int, max:Int, message: String) // Range only apply on numeric values
    case filterWords(message: String)
}

struct ValidationPreferences {
    static let letterRegEx          = "[^a-zA-Z ]"
    static let alphaNumericRegEx    = "[^a-zA-Z0-9 ]"
    static let numericRegEx         = "[^0-9]"
    static let emailRegEx           = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    static let passwordRegEx        = "(.{6,12})"
    static let domain               = "VALIDATIONFAILED"
    static let errorCode            = 501
}
