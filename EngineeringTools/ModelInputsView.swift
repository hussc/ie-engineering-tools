//
//  ModelInputsView.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import SwiftUI

struct ModelInputsView: View {
    struct SelectionOutput: Hashable, Identifiable {
        let modelType: QueueModelType
        let inputs: QueueingSystemInputs
        
        var id: String { modelType.id }
    }
    
    @State private var modelType: QueueModelType = .singleSInfiniteSize
    @State private var arrivalRate: Double = 5
    @State private var serviceRate: Double = 10
    @State private var systemLimit: Int = 20
    @State private var numberOfServers: Int = 2
    
    let output: (SelectionOutput) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Prob.Operations")
                    .font(.system(size: 32, weight: .regular))
                    .foregroundStyle(.accent)
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                
                ModelPickerView(model: $modelType)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        VariableInputView(symbol: .lambda, value: $arrivalRate)
                        VariableInputView(symbol: .mu, value: $serviceRate)
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        if modelType.supportsCustomServersCount {
                            VariableInputView(symbol: .serversCount, value: $numberOfServers)
                        }
                        
                        if modelType.supportsCustomSystemLimit {
                            VariableInputView(symbol: .systemLimit, value: $systemLimit)
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    let inputs = QueueingSystemInputs(
                        arrivalRate: max(arrivalRate, 1),
                        serviceRate: max(serviceRate, 1),
                        systemLimit: max(systemLimit, 1),
                        numberOfServers: max(numberOfServers, 1)
                    )
                    
                    self.output(.init(modelType: self.modelType, inputs: inputs))
                } label: {
                    Label("Calculate", systemImage: "function")
                }
                .buttonStyle(.primary)
                .padding(.horizontal)

            }
            .accent(.accent)
        }
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension ModelInputsView {    
    struct ModelPickerView: View {
        @Binding var model: QueueModelType
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("Pick a model")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.accent)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(QueueModelType.allCases) { model in
                            HStack {
                                Text(model.name)
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundStyle(model == self.model ? .accent : .secondary)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background {
                                Rectangle()
                                    .fill(Color.backgroundSecondary)
                            }
                            .onTapGesture {
                                self.model = model
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background {
                Rectangle()
                    .fill(Color.backgroundSecondary)
            }
        }
    }
    
    struct VariableInputView: View {
        let symbol: QSDefaultParameter
        @Binding var value: Double
        
        init(symbol: QSDefaultParameter, value: Binding<Double>) {
            self.symbol = symbol
            self._value = value
        }
        
        init(symbol: QSDefaultParameter, value: Binding<Int>) {
            self.symbol = symbol
            self._value = .init(get: {
                Double(value.wrappedValue)
            }, set: { newValue in
                value.wrappedValue = Int(newValue)
            })
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(symbol.name)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
                
                HStack(alignment: .center, spacing: 4) {
                    Text(symbol.placeholder)
                        .font(.system(size: 32, weight: .light))
                        .foregroundStyle(.black.opacity(0.1))
                    TextField("", value: $value, format: .number)
                        .font(.system(size: 32, weight: .light))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background {
                Rectangle()
                    .fill(Color.backgroundSecondary)
            }
        }
    }
}

#Preview {
    ModelInputsView() { _ in }
}

#Preview {
    ModelInputsView.VariableInputView(symbol: .lambda, value: .constant(5))
}

#Preview {
    ModelInputsView.ModelPickerView(model: .constant(.multipleSInfiniteSize))
}
