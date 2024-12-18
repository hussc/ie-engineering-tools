//
//  Double+Functions.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

extension Double {
    func powered(_ power: Double) -> Double {
        pow(self, power)
    }
    
    func powered(_ power: Int) -> Double {
        pow(self, Double(power))
    }
}

// Helper function for factorial
func factorial(_ n: Int) -> Int {
    (1...max(1, n)).reduce(1, *)
}

extension Int {
    /// Computes the factorial of an integer.
    func factorial() -> Int {
        guard self > 0 else { return 1 }
        return (1...self).reduce(1, *)
    }
}

extension Double {
    /// Computes the factorial of an integer.
    func factorial() -> Double {
        Double(Int(self).factorial())
    }
}

extension Sequence where Element: SignedNumeric {
    /// Computes the summation of a sequence after applying a transformation.
    func summation<T: SignedNumeric>(_ transform: (Element) -> T) -> T {
        self.reduce(0) { $0 + transform($1) }
    }
}
