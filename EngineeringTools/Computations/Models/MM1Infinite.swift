//
//  SingleServerInfiniteSizeQueueingModel.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

// MARK: - M/M/1:GD/∞/∞ Model
struct MM1Infinite: QueueingModelProtocol {
    let name = "M/M/1:GD/∞/∞"
    let identifier = "MM1Infinite"
    
    let supportsCustomSystemLimit = false
    let supportsCustomServersCount = false
    
    func computations(for inputs: QueueingSystemInputs) -> QueueingSystemAttributes {
        let λ = inputs.arrivalRate
        let μ = inputs.serviceRate
        let ρ = λ / μ
        
        let systemLength = λ / (μ - λ)
        let queueingLength = pow(λ, 2) / (μ * (μ - λ))
        let timeInSystem = 1 / (μ - λ)
        let timeInQueue = λ / (μ * (μ - λ))
        
        let probabilityCalc = ProbabilityCalculation(systemLimit: nil) { n in
            let probOf0 =  1 - ρ
            if n == 0 { return probOf0 }
            else { return (1 - ρ) * pow(ρ, Double(n)) }
        }
        
        return QueueingSystemAttributes(
            systemLength: systemLength,
            queueingLength: queueingLength,
            timeInSystem: timeInSystem,
            timeInQueue: timeInQueue,
            probabilityCalculation: probabilityCalc
        )
    }
}
