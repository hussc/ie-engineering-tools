//
//  QSAttribute.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

protocol QSAttribute {
    var name: String { get }
    var symbol: String { get }
}

enum QSDefaultAttribute: String, CaseIterable, QSAttribute {
    case systemLength        // Ls
    case queueLength         // Lq
    case timeInSystem        // Ws
    case timeInQueue         // Wq
    case averageBusyServers  // C(bar)
    case probabilityOfZero   // P0
    case probabilityOfN      // P(N)
    
    var name: String {
        switch self {
        case .systemLength:
            return "Average Number in System"
        case .queueLength:
            return "Average Number in Queue"
        case .timeInSystem:
            return "Average Time in System"
        case .timeInQueue:
            return "Average Time in Queue"
        case .averageBusyServers:
            return "Average Number of Busy Servers"
        case .probabilityOfZero:
            return "Probability of Zero Entities (P₀)"
        case .probabilityOfN:
            return "Probability of N Entities (P(N))"
        }
    }
    
    var symbol: String {
        switch self {
        case .systemLength:
            return "Lₛ"
        case .queueLength:
            return "Lₛ"
        case .timeInSystem:
            return "Wₛ"
        case .timeInQueue:
            return "Wₛ"
        case .averageBusyServers:
            return "C̄"
        case .probabilityOfZero:
            return "P₀"
        case .probabilityOfN:
            return "P(N)"
        }
    }
}
