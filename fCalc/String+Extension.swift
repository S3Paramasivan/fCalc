//
//  String+Extension.swift
//  
//
//  Created by SivA on 9/10/23.
//

import Foundation

extension String {
    static let supportingOperators = ["+", "-", "*", "/"]

    var double: Double {Double(self) ?? 0}
    
    var decimalFromFraction: Double? {
        let numeratorAndDenominator = self.components(separatedBy: "/")
        if numeratorAndDenominator.count == 2 {
            let numeratorNumber = numeratorAndDenominator[0]
            let denominatorNumber = numeratorAndDenominator[1]
            return (numeratorNumber.double / denominatorNumber.double)
        }
        return nil
    }
    
    var number: String? {
        if let slashRange = self.rangeOfCharacter(from: CharacterSet.init(charactersIn: "/")) {
            if let ampersandRange = self.rangeOfCharacter(from: CharacterSet.init(charactersIn: "&")), ampersandRange.lowerBound < slashRange.lowerBound {
                let wholeNumber = String(self[..<ampersandRange.lowerBound])
                let wholeAndNumeratorWithDenominator = self.components(separatedBy: "&")
                if wholeAndNumeratorWithDenominator.count == 2 {
                    let numeratorAndDenominatorNumber = wholeAndNumeratorWithDenominator[1]
                    if let decimalFromFraction = numeratorAndDenominatorNumber.decimalFromFraction {
                        let wholeNumberDouble = wholeNumber.double
                        let absoluteWholeNumber = abs(wholeNumberDouble)
                        let multplier: Double = (wholeNumberDouble.sign == .minus ? -1 : 1)
                        return String(multplier * (absoluteWholeNumber + decimalFromFraction))
                    }
                }
            }
            else if let decimalFromFraction = self.decimalFromFraction {
                return String(decimalFromFraction)
            }
        }
        else if let _ = Double(self) {
            return self
        }
        return nil
    }
    
    //MARK: - Calculation
    func evaluate() -> String? {
        let operatorsAndOperands = self.split(separator: " ")
        if operatorsAndOperands.count > 2 {
            var incorrectInputs = [String]()
            var operands = stride(from: 0, to: operatorsAndOperands.count, by: 2).map { String(operatorsAndOperands[$0]) }
            let operators = stride(from: 1, to: operatorsAndOperands.count, by: 2).map { String(operatorsAndOperands[$0]) }
            let operand = operands[0]
            var result: CGFloat = 0
            if let number = operand.number {
                result = Double(number) ?? Double(0)
            }
            else {
                incorrectInputs.append(operand)
            }
            operands.removeFirst()
            if operators.contains(where: {!String.supportingOperators.contains($0)}) {
                print("Having one or more unsupported operators \nSupporting operatos are \(String.supportingOperators.joined(separator: ", "))")
            }
            else if operands.count == operators.count {
                operands.enumerated().forEach { (index, operand) in
                    if let number = operand.number {
                        let expressionFormat = String(format: "(%f)%@(%@)", result, operators[index], number)
                        let arithmeticExpression = NSExpression(format: expressionFormat)
                        if let expressionValue = arithmeticExpression.expressionValue(with: nil, context: nil) as? NSNumber {
                            result = expressionValue.doubleValue
                        } else {
                            print("Experiecing some problem in arithmetic operation!")
                        }
                    }
                    else {
                        incorrectInputs.append(operand)
                    }
                }
                
                if incorrectInputs.isNotEmpty {
                    print("\nWarning")
                    let output = incorrectInputs.neglectMessage
                    let outputLines = [String](repeating: "-", count: output.count).joined()
                    
                    print(outputLines)
                    print(output)
                    print(outputLines)
                }

                let wholeNumber = Int(result)
                let decimalNumber = result.truncatingRemainder(dividingBy: 1)
                var resultString = ""
                if wholeNumber != 0 {
                    resultString = String(wholeNumber)
                }
                if decimalNumber != 0 {
                    resultString += resultString.isEmpty ? "" : "&"
                    let absoluteDecimalNumber = wholeNumber != 0 ? abs(decimalNumber) : decimalNumber
                    resultString += absoluteDecimalNumber.fraction
                }
                let output = self + " = " + resultString
                let outputLines = [String](repeating: "-", count: output.count).joined()

                print("\nResult")
                print(outputLines)
                print(output)
                print(outputLines)
                return resultString
            }
            else {
                print("One operand is missing!")
            }
        }
        else {
            print("Use two operands and one operator at least with operators and operands separated by space for the result to generate!\n\nFor Example: 1&3/4 - 2")
        }
        print("\n")
        return nil
    }
}
