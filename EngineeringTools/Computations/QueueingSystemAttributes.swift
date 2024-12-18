//
//  QueueingSystemAttributes.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

struct ProbabilityCalculation {
    let systemLimit: Int?
    let probabilityOf: (_ havingNEntities: Int) -> Double
    
    var probabilityOf0: Double { probabilityOf(0) }
    var probabilityOfN: Double? { systemLimit.map { probabilityOf($0) } }
    
    func callAsFunction(_ havingNEntities: Int) -> Double {
        if let systemLimit, havingNEntities > systemLimit {
            return 0
        }
        
        return probabilityOf(havingNEntities)
    }
}

struct QueueingSystemAttributes {
    let systemLength: Double
    let queueingLength: Double
    let timeInSystem: Double
    let timeInQueue: Double
    let probabilityCalculation: ProbabilityCalculation
    
    var averageBusyServers: Double {
        systemLength - queueingLength
    }
}

extension QueueingSystemAttributes {
    static var notSupportedYet: Self {
        .init(systemLength: -1, queueingLength: -1, timeInSystem: -1, timeInQueue: -1, probabilityCalculation: .init(systemLimit: nil, probabilityOf: { _ in 0 }))
    }
}
