//
//  CalculatorModel.swift
//  MLMath
//
//  Created by Santos on 2018-09-15.
//  Copyright © 2018 Santos. All rights reserved.
//

import Foundation
class CalculatorModel {
    private (set) var expression = Stack<String>()
    private static var NUMBERS = "0123456789"
    private static var OPERATORS = "+-/x"
    public func addToExpression(newAddittion : String){
        if (expression.count == 0 && newAddittion == "0") {return}
        if (expression.peak() != nil && Int(expression.peak()!) != nil &&
            CalculatorModel.NUMBERS.contains(newAddittion)) {
            //Combine number if there is no operator inbetween eg. Combine 5 & 5 -> 55
            let baseNum = expression.pop()
            expression.push(item: baseNum!+newAddittion)
        }
        else if !((expression.peak() != nil && CalculatorModel.OPERATORS.contains(newAddittion) &&
            CalculatorModel.OPERATORS.contains(expression.peak()!))) {
            //Ensures operators are not stacked back to bag eg. 5 + + 6
            expression.push(item: newAddittion)
        }
    }
    public func undoAdditionToExpression() {
        let removedString = expression.pop()
        guard let stringCount = removedString?.count else {return}
        if (stringCount >= 2){
            expression.push(item: String(removedString?.dropLast() ?? ""))
        }
    }
    
    public func getExpression() -> String {
        var stringExpression = ""
        var poppedFirstItem = true
        let reverseStack = expression.getStackInReverse()
        while (!reverseStack.isEmpty()){
            let poppedValue = reverseStack.pop()!
            if (!(poppedFirstItem && poppedValue == "0")) {
                stringExpression += String(poppedValue)
            }
            poppedFirstItem = false
        }
        if (stringExpression == "") {stringExpression = "0"}
        return stringExpression
    }
    public func calculateExpression() -> String?{
        guard let rightStringOperand = expression.pop() else {return nil}
        guard let operation = expression.pop() else {expression.push(item:String(rightStringOperand));return nil}
        guard let leftStringOperand = expression.pop() else {expression.push(item:operation);expression.push(item:String(rightStringOperand));return nil}
        guard let rightOperand = Int(rightStringOperand) else {return nil}
        guard let leftOperand = Int(leftStringOperand) else {return nil}
        var answer = 0
        var operatorString = ""
        switch operation {
            case "+":
                answer = leftOperand + rightOperand
                operatorString = "+"
                expression.push(item: String(answer))
            case "-":
                answer = leftOperand - rightOperand
                operatorString = "-"
                expression.push(item: String(answer))
            case "/":
                answer = leftOperand / rightOperand
                operatorString = "/"

                expression.push(item: String(answer))
            case "x":
                answer = leftOperand * rightOperand
                expression.push(item: String(answer))
                operatorString = "x"
            default:
                return nil
        }
        
        return leftStringOperand + operatorString + rightStringOperand + "=" + String(answer)

    }
    public func clearExpression() {
        self.expression = Stack<String>()
        
    }
}
