//
//  MLMathTests.swift
//  MLMathTests
//
//  Created by Santos on 2018-09-14.
//  Copyright © 2018 Santos. All rights reserved.
//

import XCTest
@testable import MLMath

class MLMathTests: XCTestCase {
    func testStackPopPushPeak() {
        let stack = Stack<String>()
        stack.push(item: "first")
        stack.push(item: "second")
        stack.push(item: "third")
        XCTAssertEqual(stack.peak(), "third")
        XCTAssertEqual(stack.pop(), "third")
        XCTAssertEqual(stack.peak(), "second")
        XCTAssertEqual(stack.pop(), "second")
        XCTAssertEqual(stack.peak(), "first")
        XCTAssertEqual(stack.pop(), "first")
        XCTAssertEqual(stack.pop(), nil)

    }
    func testStackReverse() {
        let stack = Stack<Int>()
        stack.push(item: 0)
        stack.push(item: 1)
        stack.push(item: 2)
        let reverseStack = stack.getStackInReverse()
        XCTAssertEqual(reverseStack.isEmpty(), false)
        XCTAssertEqual(reverseStack.pop()!, Optional(0))
        XCTAssertEqual(reverseStack.pop()!, Optional(1))
        XCTAssertEqual(reverseStack.pop()!, Optional(2))
        XCTAssertEqual(reverseStack.isEmpty(), true)
        XCTAssertEqual(stack.isEmpty(), false)
        XCTAssertEqual(stack.pop(), Optional(2))
        XCTAssertEqual(stack.pop(), Optional(1))
        XCTAssertEqual(stack.pop(), Optional(0))
        XCTAssertEqual(stack.isEmpty(), true)
    }
    
    func testCalculatorModel() {
        let model = CalculatorModel()
        model.addToExpression(newAddittion: 1)
        model.addToExpression(newAddittion: 0)
        model.addToExpression(newAddittion: 0)
        XCTAssertEqual(model.getExpression(), "100")
        model.undoAdditionToExpression()
        XCTAssertEqual(model.getExpression(), "10")
        model.undoAdditionToExpression()
        XCTAssertEqual(model.getExpression(), "1")
        model.undoAdditionToExpression()
        XCTAssertEqual(model.getExpression(), "")
     




        

    }
   
    
}
