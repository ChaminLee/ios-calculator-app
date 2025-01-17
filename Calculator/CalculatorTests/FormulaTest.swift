//
//  FomulaTest.swift
//  CalculatorTests
//
//  Created by 이차민 on 2021/11/11.
//

import XCTest

class FormulaTest: XCTestCase {
    var formula = Formula(operands: CalculatorItemQueue<Double>(), operators: CalculatorItemQueue<Operator>())
    
    override func setUp() {
        formula = Formula(operands: CalculatorItemQueue<Double>(), operators: CalculatorItemQueue<Operator>())
    }
    
    override func tearDown() {
        formula.operands.removeAll()
        formula.operators.removeAll()
    }
    
    func test_처음_연산할_때_피연산자가_없는_상태인_경우_에러를_반환하는지() throws {
        XCTAssertThrowsError(try formula.result()) { error in
            XCTAssertEqual(error as? CalculationItemQueueError, CalculationItemQueueError.hasNoElement)
        }
    }
    
    func test_3개의_수를_덧셈만_하는_경우_정상적으로_연산되는지() throws {
        [3.0, -2.0, 15.0].forEach { number in
            formula.operands.enqueue(number)
        }
        
        let operators: [Character] = ["+", "+"]
        
        operators.forEach { arithmetic in
            guard let arithmetic = Operator(rawValue: arithmetic) else {
                return
            }
            
            formula.operators.enqueue(arithmetic)
        }
        
        let calculationResult = try formula.result()
        XCTAssertEqual(16.0, calculationResult)
    }
    
    func test_3개의_수를_뺄셈만_하는_경우_정상적으로_연산되는지() throws {
        [3.0, -2.0, 15.0].forEach { number in
            formula.operands.enqueue(number)
        }
        
        let operators: [Character] = ["−", "−"]
        
        operators.forEach { arithmetic in
            guard let arithmetic = Operator(rawValue: arithmetic) else {
                return
            }
            
            formula.operators.enqueue(arithmetic)
        }
        
        let calculationResult = try formula.result()
        XCTAssertEqual(-10.0, calculationResult)
    }
    
    func test_3개의_수를_곱셈만_하는_경우_정상적으로_연산되는지() throws {
        [3.0, -2.0, 15.0].forEach { number in
            formula.operands.enqueue(number)
        }
        
        let operators: [Character] = ["×", "×"]
        
        operators.forEach { arithmetic in
            guard let arithmetic = Operator(rawValue: arithmetic) else {
                return
            }
            
            formula.operators.enqueue(arithmetic)
        }
        
        let calculationResult = try formula.result()
        XCTAssertEqual(-90.0, calculationResult)
    }
    
    func test_3개의_수를_나눗셈만_하는_경우_정상적으로_연산되는지() throws {
        [15.0, 3.0, -2.0].forEach { number in
            formula.operands.enqueue(number)
        }
        
        let operators: [Character] = ["÷", "÷"]
        
        operators.forEach { arithmetic in
            guard let arithmetic = Operator(rawValue: arithmetic) else {
                return
            }
            
            formula.operators.enqueue(arithmetic)
        }
        
        let calculationResult = try formula.result()
        XCTAssertEqual(-2.5, calculationResult)
    }
    
    func test_0으로_나누는_경우가_포함되어있는_경우_에러가_반환되는지() throws {
        [15.0, 3.0, 0.0, -2.0].forEach { number in
            formula.operands.enqueue(number)
        }
        
        let operators: [Character] = ["÷", "÷", "+"]
        
        operators.forEach { arithmetic in
            guard let arithmetic = Operator(rawValue: arithmetic) else {
                return
            }
            
            formula.operators.enqueue(arithmetic)
        }
                
        XCTAssertThrowsError(try formula.result()) { error in
            XCTAssertEqual(error as? OperationError, OperationError.dividedByZero)
        }
    }
    
    func test_일반적인_우선순위가_아닌_연산자의_순서에_따라_값이_연산되는지() throws {
        [15.0, 3.0, -2.0].forEach { number in
            formula.operands.enqueue(number)
        }
        
        let operators: [Character] = ["+", "×"]
        
        operators.forEach { arithmetic in
            guard let arithmetic = Operator(rawValue: arithmetic) else {
                return
            }
            
            formula.operators.enqueue(arithmetic)
        }
        
        let calculationResult = try formula.result()
        XCTAssertEqual(-36.0, calculationResult)
    }
    
    func test_연산자를_마지막으로_입력한_경우_해당_연산자는_사용되지_않고_이전까지의_결과를_반환하는지() throws {
        [15.0, 3.0].forEach { number in
            formula.operands.enqueue(number)
        }
        
        let operators: [Character] = ["+", "×"]
        
        operators.forEach { arithmetic in
            guard let arithmetic = Operator(rawValue: arithmetic) else {
                return
            }
            
            formula.operators.enqueue(arithmetic)
        }
        
        let calculationResult = try formula.result()
        XCTAssertEqual(18.0, calculationResult)
    }
}
