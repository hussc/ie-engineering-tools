//
//  MSFSQueueingModel.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

// MARK: - M/M/C:GD/N/∞ Model
struct MMCLimited: QueueingModelProtocol {
    let name = "M/M/C:GD/N/∞"
    let identifier = "MMCLimited"
    
    let supportsCustomSystemLimit = true
    let supportsCustomServersCount = true
    
    func computations(for inputs: QueueingSystemInputs) -> QueueingSystemAttributes {
        let lambda = inputs.arrivalRate
        let mu = inputs.serviceRate
        let C = Double(inputs.numberOfServers)
        let N = Double(inputs.systemLimit)
        let rho = lambda / mu
        
        let p0: Double
        let Lq: Double
        
        if (rho / C) != 1 {
            let p0Sum = (0...(Int(C)  - 1)).summation { number in
                rho.powered(number) / Double(number.factorial())
            }
            
            let p0Tail = (rho.powered(C) * (1 - (rho / C).powered(N - C + 1))) / (C.factorial() * (1 - (rho / C)))
            
            p0 = 1 / (p0Sum + p0Tail)
            
            let Lq1 = rho.powered(C + 1) / ((C - 1).factorial() * (C - rho).powered(2))
            let Lq2 = 1 - (rho / C).powered(N - C + 1) - ((N - C + 1) * (1 - (rho / C)) * (rho / C).powered(N - C))
            Lq = Lq1 * Lq2 * p0
        } else {
            let p0Sum = (0...(Int(C) - 1)).summation { number in
                rho.powered(number) / Double(number.factorial())
            }
            
            let p0Tail = (rho.powered(C) * (1 - (rho / C).factorial())) * (N - C + 1)
            p0 = 1 / (p0Sum + p0Tail)
            
            let Lq1 = (rho.powered(C) * (N - C) * (N - C + 1)) / (2 * C.factorial())
            Lq = Lq1 * p0
        }
            
        let probabilityCalc = ProbabilityCalculation(systemLimit: inputs.systemLimit) { n in
            if n == 0 { return p0 }
            else { return rho.powered(n) / (C.factorial() * C.powered(Double(n) - C)) }
        }
        
        let lambdaEffec = lambda * (1 - probabilityCalc.probabilityOf(Int(N)))
        let Ls = Lq + (lambdaEffec / mu)
        let Wq = Lq / lambdaEffec
        let Ws = Wq + (1 / mu)
        
        
        return QueueingSystemAttributes(
            systemLength: Ls,
            queueingLength: Lq,
            timeInSystem: Ws,
            timeInQueue: Wq,
            probabilityCalculation: probabilityCalc
        )
    }
}
