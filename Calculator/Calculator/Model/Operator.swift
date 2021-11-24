//
//  Operator.swift
//  Calculator
//
//  Created by 이차민 on 2021/11/11.
//

import Foundation

enum Operator: Character, CaseIterable, CalculateItem {
    case add = "+"
    case subtract = "−"
    case divide = "÷"
    case multiply = "×"
    
    static let marks = allCases.map { $0.rawValue }
    
    func calculate(lhs: Double, rhs: Double) throws -> Double {
        switch self {
        case .add:
            return add(lhs: lhs, rhs: rhs)
        case .subtract:
            return subtract(lhs: lhs, rhs: rhs)
        case .divide:
            return try divide(lhs: lhs, rhs: rhs)
        case .multiply:
            return multiply(lhs: lhs, rhs: rhs)
        }        
    }
    
    private func add(lhs: Double, rhs: Double) -> Double {
        let result = Decimal(lhs) + Decimal(rhs)
        
        return result.doubleValue
    }
    
    private func subtract(lhs: Double, rhs: Double) -> Double {
        let result = Decimal(lhs) - Decimal(rhs)
        
        return result.doubleValue
    }
    
    private func divide(lhs: Double, rhs: Double) throws -> Double {
        if rhs == 0.0 {
            throw OperationError.dividedByZero
        }
        
        let result = Decimal(lhs) / Decimal(rhs)
        
        return result.doubleValue
    }
    
    private func multiply(lhs: Double, rhs: Double) -> Double {
        let result = Decimal(lhs) * Decimal(rhs)
        
        return result.doubleValue
    }
}
