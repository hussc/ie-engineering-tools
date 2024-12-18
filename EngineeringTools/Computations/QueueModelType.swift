//
//  QueueModelType.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import SwiftUI

enum QueueModelType: String, CaseIterable, Identifiable, Hashable {
    case singleSInfiniteSize
    case singleSFiniteSize
    case multipleSInfiniteSize
    case multipleSFiniteSize
    
    var model: QueueingModelProtocol {
        switch self {
        case .singleSInfiniteSize: MM1Infinite()
        case .singleSFiniteSize: MM1Limited()
        case .multipleSInfiniteSize: MMCInfinite()
        case .multipleSFiniteSize: MMCLimited()
        }
    }
    
    var id: String { identifier }
}

extension QueueModelType: QueueingModelProtocol {
    var name: String {
        model.name
    }
    
    var identifier: String {
        model.identifier
    }
    
    var supportsCustomSystemLimit: Bool {
        model.supportsCustomSystemLimit
    }
    
    var supportsCustomServersCount: Bool {
        model.supportsCustomServersCount
    }
    
    func computations(for inputs: QueueingSystemInputs) -> QueueingSystemAttributes {
        model.computations(for: inputs)
    }
}
