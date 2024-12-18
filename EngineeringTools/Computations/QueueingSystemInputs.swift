//
//  QueueingSystemInputs.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

struct QueueingSystemInputs: Equatable, Hashable {
    let arrivalRate: Double
    let serviceRate: Double
    let systemLimit: Int
    let numberOfServers: Int
}

extension QueueingSystemInputs {
    var rho: Double {
        arrivalRate / serviceRate
    }
}
