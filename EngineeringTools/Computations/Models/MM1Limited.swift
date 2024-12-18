//
//  SSFSQueueingModel.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

struct MM1Limited: QueueingModelProtocol {
    let name = "M/M/1:GD/N/∞"
    let identifier = "MM1Limited"
    
    let supportsCustomSystemLimit = true
    let supportsCustomServersCount = false
    
    func computations(for inputs: QueueingSystemInputs) -> QueueingSystemAttributes {
        let λ = inputs.arrivalRate
        let μ = inputs.serviceRate
        let N = Double(inputs.systemLimit)
        let ρ = λ / μ
        
        let probabilityCalc = ProbabilityCalculation(systemLimit: inputs.systemLimit) { n in
            if n == 0 {
                return (1 - ρ) / (1 - ρ.powered(N + 1))
            }
            
            return (ρ.powered(n) * (1 - ρ)) / (1 - ρ.powered(n + 1))
        }

        let pN = probabilityCalc.probabilityOf(Int(N))
        let lambdaEffec = λ * (1 - pN)
        
        let systemLength = N - (N + 1 - ρ) * pN
        let queueingLength = systemLength - lambdaEffec / μ
        let timeInSystem = systemLength / lambdaEffec
        let timeInQueue = timeInSystem - (1 / μ)
        
        return QueueingSystemAttributes(
            systemLength: systemLength,
            queueingLength: queueingLength,
            timeInSystem: timeInSystem,
            timeInQueue: timeInQueue,
            probabilityCalculation: probabilityCalc
        )
    }
}

