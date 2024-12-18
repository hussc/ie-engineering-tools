//
//  QueueModelProtocol.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import Foundation

protocol QueueingModelProtocol {
    var name: String { get }
    var identifier: String { get }
    
    var supportsCustomSystemLimit: Bool { get }
    var supportsCustomServersCount: Bool { get }
    
    func computations(for inputs: QueueingSystemInputs) -> QueueingSystemAttributes
    
    /*
     Do we need to ask the model to provide implementation for it's implementation for the attributes? perhaps :))
     */
}

extension QueueingModelProtocol {
    var name: String { identifier }
}
