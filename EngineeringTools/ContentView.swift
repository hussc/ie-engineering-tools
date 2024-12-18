//
//  ContentView.swift
//  QueueingModels
//
//  Created by Hussein ElRyalat on 9/12/24.
//

import SwiftUI
import LaTeXSwiftUI

struct ContentView: View {
    @State private var navigationPath = NavigationPath()
    @State private var selectedParameters: ModelInputsView.SelectionOutput?
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ModelInputsView() { selection in
                self.selectedParameters = selection
            }
            .sheet(item: $selectedParameters, content: { selection in
                QueueingModelPreviewView(
                    isPresented: .init(get: {
                        selectedParameters != nil
                    }, set: { if !$0 { selectedParameters = nil }}),
                    model: selection.modelType,
                    inputs: selection.inputs
                )
            })
        }
    }
}

#Preview {
    ContentView()
}
