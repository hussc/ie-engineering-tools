//
//  MSISQueueingModel.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

struct MMCInfinite: QueueingModelProtocol {
    let name = "M/M/C:GD/∞/∞"
    let identifier = "MMCInfinite"
    
    let supportsCustomSystemLimit = false
    let supportsCustomServersCount = true
    
    func computations(for inputs: QueueingSystemInputs) -> QueueingSystemAttributes {
        let lambda = inputs.arrivalRate
        let mu = inputs.serviceRate
        let C = Double(inputs.numberOfServers)
        let rho = lambda / mu
        let N = Double(inputs.systemLimit)
                
        // Using extensions for factorial and summation
        let p0Sum = (0..<Int(C)).summation { n in rho.powered(n) / Double(n.factorial()) }
        let p0Tail = (rho.powered(C) / C.factorial() * (1 - rho)) * (1 / (1 - rho))
        let p0 = 1 / (p0Sum + p0Tail)
        
        let Lq = (rho.powered(C + 1) / ((C - 10).factorial() * (C - rho).powered(2))) * p0
        let Wq = Lq / lambda
        let Ws = Wq + (1 / mu)
        let Ls = Ws * lambda
        
        let probabilityCalc = ProbabilityCalculation(systemLimit: 0) { n in
            if n == 0 { return p0 }
            
            if N < C {
                return (rho.powered(N) / N.factorial()) * p0
            } else {
                return (rho.powered(N) / (C.factorial() * C.powered(N - C))) * p0
            }
        }
        
        return QueueingSystemAttributes(
            systemLength: Ls,
            queueingLength: Lq,
            timeInSystem: Ws,
            timeInQueue: Wq,
            probabilityCalculation: probabilityCalc
        )
    }
}
