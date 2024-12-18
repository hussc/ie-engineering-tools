//
//  QSParameter.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

protocol QSParameter {
    var name: String { get }
    var symbol: String { get }
}

enum QSDefaultParameter: String, CaseIterable, QSParameter {
    case lambda = "λ"
    case mu = "μ"
    case systemLimit = "N"
    case serversCount = "C"
    
    var name: String {
        switch self {
        case .lambda: return "Arrival Rate"
        case .mu: return "Service Rate"
        case .systemLimit: return "System Limit"
        case .serversCount: return "Servers Count"
        }
    }
    
    var symbol: String { rawValue }
    
    var placeholder: String {
        return rawValue + "="
    }
}
