//
//  IsLoadingEnvironmentKey.swift
//  bigfive-assessment
//
//  Created by Hussein ElRyalat on 5/12/24.
//
import SwiftUI

public struct IsLoadingEnvironmentKey: EnvironmentKey {
    public static var defaultValue: Bool = false
}

extension EnvironmentValues {
    public var isLoading: Bool {
        get { self[IsLoadingEnvironmentKey.self] }
        set { self[IsLoadingEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func isLoading(_ value: Bool) -> some View {
        self.environment(\.isLoading, value)
            .environment(\.isEnabled, !value)
    }
}
