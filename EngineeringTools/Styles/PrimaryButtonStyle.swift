//
//  PrimaryButtonStyle.swift
//  bigfive-assessment
//
//  Created by Hussein ElRyalat on 3/12/24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.isLoading) var isLoading
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.accent)
                .edgesIgnoringSafeArea(.bottom)
            
            HStack {
                Spacer()
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.backgroundPrimary)
                } else {
                    configuration.label
                        .foregroundColor(.backgroundPrimary)
                        .font(.headline)
                }
                Spacer()
            }
        }
        .opacity(isEnabled ? 1 : 0.5)
        .frame(height: 50)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self {
        .init()
    }
}

#Preview {
    HStack {
        Spacer()
        Button {
            print("Hello")
        } label: {
            Label("Hello", systemImage: "arrow.forward")
                .labelStyle(.wide)
        }
        Spacer()
    }
}
