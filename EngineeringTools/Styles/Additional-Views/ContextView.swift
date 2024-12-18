//
//  ContextView.swift
//  bigfive-assessment
//
//  Created by Hussein ElRyalat on 5/12/24.
//

import SwiftUI

public struct ContextView<Content, ContentView: View>: View {
    public enum ContentState {
        case failure(Error)
        case loading
        case content(Content)
    }
    
    @State private var error: Error? = nil
    @State private var isLoading = false
    @State private var contentState: ContentState = .loading
    
    private var task: @Sendable () async throws -> Content
    private var contentView: ((Content) -> ContentView)
    
    public init(task: @escaping @Sendable () async throws -> Content,
         contentView: @escaping ((Content) -> ContentView)) {
        self.task = task
        self.contentView = contentView
    }
    
    public init(task: @escaping @Sendable () async throws -> Content,
         contentView: @escaping @autoclosure (() -> ContentView)) {
        self.task = task
        self.contentView = { _ in contentView() }
    }
    
    public var body: some View {
        Group {
            view(for: contentState)
        }.task {
            do {
                let content = try await self.task()
                self.contentState = .content(content)
            } catch {
                self.contentState = .failure(error)
            }
        }
    }
    
    @ViewBuilder func view(for state: ContentState) -> some View {
        switch state {
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
        case .failure(let error):
            FailureStateView(contents: .init(
                title: "defaults.errortitle",
                error: error,
                onRetry: retryAgain,
                retryTitle: "retry"
            ))
        case .content(let content):
            self.contentView(content)
        }
    }
    
    private func retryAgain() {
        contentState = .loading
        Task {
            do {
                let content = try await self.task()
                self.contentState = .content(content)
            } catch {
                self.contentState = .failure(error)
            }
        }
    }
}

extension View {
    @_disfavoredOverload
    public func task(_ task: @Sendable @escaping @MainActor () async throws -> Void) -> some View {
        ContextView(task: task) {
            self
        }
    }
}
