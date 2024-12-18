//
//  CardBackgroundStyle.swift
//  bigfive-assessment
//
//  Created by Hussein ElRyalat on 5/12/24.
//

import SwiftUI

public enum CardAlignment {
    case leading
    case center
    case trailing
}

public enum CardIndentionStyle {
    case secondary
    case tertiary

    public var backgroundColor: Color {
        switch self {
        case .secondary:
            return .backgroundSecondary
        case .tertiary:
            return .backgroundSecondary
        }
    }

    public var cornerRadius: CGFloat {
        switch self {
        case .secondary:
            return 6
        case .tertiary:
            return 4
        }
    }

    public var paddingHorizontal: CGFloat {
        switch self {
        case .secondary:
            return 12
        case .tertiary:
            return 4
        }
    }

    public var paddingVertical: CGFloat {
        switch self {
        case .secondary:
            return 4
        case .tertiary:
            return 8
        }
    }
}

public struct CardIndentionEnvironmentKey: EnvironmentKey {
    public static var defaultValue: CardIndentionStyle = .secondary
}

public struct CardAlignmentEnvironmentKey: EnvironmentKey {
    public static var defaultValue: CardAlignment = .leading
}

extension EnvironmentValues {
    public var cardAlignment: CardAlignment {
        get { self[CardAlignmentEnvironmentKey.self] }
        set { self[CardAlignmentEnvironmentKey.self] = newValue }
    }
}

extension EnvironmentValues {
    public var cardIndentionStyle: CardIndentionStyle {
        get { self[CardIndentionEnvironmentKey.self] }
        set { self[CardIndentionEnvironmentKey.self] = newValue }
    }
}

public struct CardBackgroundView<Content: View>: View {
    @Environment(\.cardIndentionStyle) var cardIndentionStyle
    @Environment(\.cardAlignment) var cardAlignment

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        HStack {
            if cardAlignment == .trailing || cardAlignment == .center {
                Spacer()
            }

            content()

            if cardAlignment == .leading || cardAlignment == .center {
                Spacer()
            }
        }
        .padding(.horizontal, cardIndentionStyle.paddingHorizontal)
        .padding(.vertical, cardIndentionStyle.paddingVertical)
        .background {
            RoundedRectangle(cornerRadius: cardIndentionStyle.cornerRadius).foregroundColor(cardIndentionStyle.backgroundColor)
        }
    }
}

extension View {
    public func cardIndentionStyle(_ style: CardIndentionStyle) -> some View {
        environment(\.cardIndentionStyle, style)
    }

    public func cardAlignment(_ alignment: CardAlignment) -> some View {
        environment(\.cardAlignment, alignment)
    }

    public func cardBackground() -> some View {
        CardBackgroundView(content: { self })
    }
}

#Preview {
    Text("Hello World")
        .cardBackground()
        .cardAlignment(.leading)
        .padding()
}
