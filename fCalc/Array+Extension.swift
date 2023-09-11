//
//  Array+Extension.swift
//  Testing
//
//  Created by SivA on 9/11/23.
//

import Foundation

extension Array<String> {
    var isNotEmpty: Bool {!self.isEmpty}
    
    private var isMultipleItems: Bool {self.count > 1}
    
    private var plurarSuffix: String {
        self.isMultipleItems ? "s" : ""
    }
    
    private var isOrAre: String {
        self.isMultipleItems ? "are" : "is"
    }
    
    var neglectMessage: String {
        var warningMessage = "The number"
        warningMessage += self.plurarSuffix
        warningMessage += " "
        warningMessage += self.joined(separator: ", ")
        warningMessage += " "
        warningMessage += self.isOrAre
        warningMessage += " neglected for the calculation as "
        if self.isMultipleItems {
            warningMessage += "they are not numbers"
        }
        else {
            warningMessage += "it is not a number"
        }
        warningMessage += "!"
        return warningMessage
    }
}
