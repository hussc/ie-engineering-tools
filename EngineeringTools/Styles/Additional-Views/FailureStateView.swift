//
//  FailureStateView.swift
//  bigfive-assessment
//
//  Created by Hussein ElRyalat on 5/12/24.
//

import SwiftUI

public struct FailureStateView: View {
    public struct Contents {
        let title: String?
        let subtitle: String
        let onRetry: (() -> Void)?
        let retryTitle: String?
        
        public init(title: String?, error: Error, onRetry: (() -> Void)? = nil, retryTitle: String? = nil) {
            self.title = title
            self.subtitle = error.localizedDescription
            self.onRetry = onRetry
            self.retryTitle = retryTitle
        }
        
        public init(title: String?, subtitle: String, onRetry: (() -> Void)? = nil, retryTitle: String? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.onRetry = onRetry
            self.retryTitle = retryTitle
        }
    }

    let contents: Contents
    
    public init(contents: Contents) {
        self.contents = contents
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 4) {
                if let title = contents.title {
                    Text(title)
                        .font(.title)
                        .foregroundColor(.textPrimary)
                }
                
                Text(contents.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
            }

            
            if let onRetry = contents.onRetry, let retryTitle = contents.retryTitle {
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    onRetry()
                } label: {
                    HStack {
                        Label(retryTitle, systemImage: "arrow.counterclockwise")
                        Spacer()
                    }
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.vertical)
            }
        }
        .padding(.horizontal, 16)
        .multilineTextAlignment(.leading)
        .lineLimit(nil)
    }
}

struct FailureStateView_Previews: PreviewProvider {
    static var previews: some View {
        FailureStateView(contents: .init(title: "Something went wrong",
                                         error: NSError.init(domain: "me.sketch.error", code: -1),
                                         onRetry: nil,
                                         retryTitle: nil))
    }
}

