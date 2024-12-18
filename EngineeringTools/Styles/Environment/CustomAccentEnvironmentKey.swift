//
//  CustomAccentEnvironmentKey.swift
//  bigfive-assessment
//
//  Created by Hussein ElRyalat on 5/12/24.
//


import SwiftUI

public struct CustomAccentEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Color = .textPrimary
}

extension EnvironmentValues {
    public var accent: Color {
        get { self[CustomAccentEnvironmentKey.self] }
        set { self[CustomAccentEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func accent(_ color: Color) -> some View {
        self.environment(\.accent, color)
    }
}



