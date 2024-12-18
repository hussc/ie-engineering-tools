//
//  TrailingIconLabelStyle.swift
//  bigfive-assessment
//
//  Created by Hussein ElRyalat on 5/12/24.
//
import SwiftUI

public struct TrailingIconLabelStyle: LabelStyle {
    public init() { }
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    public static var trailingIcon: Self {
        .init()
    }
}

public struct WideLabelStyle: LabelStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            Spacer().layoutPriority(0)
            configuration.icon
        }
    }
}

extension LabelStyle where Self == WideLabelStyle {
    public static var wide: Self {
        .init()
    }
}

public struct TintedIconLabelStyle: LabelStyle {
    @Environment(\.accent) var accent
    
    public init() { }
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .foregroundColor(accent)
            configuration.title
        }
    }
}

extension LabelStyle where Self == TintedIconLabelStyle {
    public static var tintedIcon: Self {
        .init()
    }
}
