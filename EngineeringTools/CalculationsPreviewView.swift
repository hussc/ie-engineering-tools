//
//  CalculationsPreviewView.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import SwiftUI
import LaTeXSwiftUI

struct QueueingModelPreviewView: View {
    @Binding var isPresented: Bool
    
    let model: QueueingModelProtocol
    let inputs: QueueingSystemInputs
    
    @State private var attributes: QueueingSystemAttributes?
    
    @ViewBuilder
    var steadyState: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Steady-State Transition Diagram", systemImage: "arrowshape.bounce.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.backgroundPrimary)
                .padding(.horizontal, 20)

            
            let systemLimit = model.supportsCustomSystemLimit ? inputs.systemLimit : 100
            
            HorizontalTransitionDiagramView(
                maxStates: systemLimit,
                arrivalRate: inputs.arrivalRate,
                serviceRate: inputs.serviceRate
            )
            
            Text("Tap on one of the states to see it’s stats")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.backgroundPrimary)
                .padding(.horizontal, 20)
        }
    }
        
    @ViewBuilder
    var systemAttributesView: some View {
        if let attributes = attributes {
            VStack(alignment: .leading, spacing: 8) {
                Label("System Attributes", systemImage: "compass.drawing")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.backgroundPrimary)
                    .padding(.horizontal, 20)
                
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center, spacing: 0) {
                        VariablePreviewView(attribute: .queueLength, value: attributes.queueingLength)
                        VariablePreviewView(attribute: .systemLength, value: attributes.systemLength)
                        VariablePreviewView(attribute: .timeInQueue, value: attributes.timeInQueue)
                        VariablePreviewView(attribute: .timeInSystem, value: attributes.timeInSystem)
                        VariablePreviewView(attribute: .averageBusyServers, value: attributes.averageBusyServers)
                        VariablePreviewView(attribute: .probabilityOfN, value: attributes.probabilityCalculation.probabilityOf(1))
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 4) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.backgroundPrimary)
                    }
                    .padding(.bottom, 10)

                    
                    Text(model.identifier)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.backgroundPrimary)
                    Text("Calculations Preview")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundStyle(.backgroundPrimary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                systemAttributesView
                steadyState
                
                Spacer()
            }
        }
        .background {
            Rectangle()
                .fill(.accent)
                .ignoresSafeArea(edges: .all)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            // Perform the computation when the view appears
            attributes = model.computations(for: inputs)
        }
    }
}

extension QueueingModelPreviewView {
    struct VariablePreviewView: View {
        let attribute: QSDefaultAttribute
        let value: Double
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(attribute.symbol)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.backgroundPrimary)
                Text(value, format: .number)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.backgroundPrimary)
            }
            .padding(20)
            .background {
                Rectangle()
                    .fill(Color.backgroundPrimary.opacity(0.05))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    QueueingModelPreviewView(
        isPresented: .constant(false),
        model: MM1Infinite(),
        inputs: QueueingSystemInputs(
            arrivalRate: 2.0,
            serviceRate: 3.0,
            systemLimit: 5,
            numberOfServers: 2
        )
    )
}

#Preview {
    QueueingModelPreviewView.VariablePreviewView(attribute: .probabilityOfN, value: 2.0)
}
