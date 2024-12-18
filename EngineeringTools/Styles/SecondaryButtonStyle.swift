//
//  SecondaryButtonStyle.swift
//  bigfive-assessment
//
//  Created by Hussein ElRyalat on 3/12/24.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.accent) var accent
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.isLoading) var isLoading

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.border)
                .edgesIgnoringSafeArea(.bottom)
            
            HStack {
                Spacer()
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(accent)
                } else {
                    configuration.label
                        .foregroundColor(.textPrimary)
                        .font(.headline.bold())
                }
                
                Spacer()
            }

        }
        .opacity(isEnabled ? 1 : 0.5)
        .frame(height: 50)
    }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: Self {
        .init()
    }
}
