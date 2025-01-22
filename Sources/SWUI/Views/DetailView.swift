//
//  DetailView.swift
//  otus_dz2
//
//  Created by Ruslan Sabirov on 07/01/25.
//

import SwiftUI
import Combine

@available(iOS 18, macOS 14, *)
public struct DetailContainerView: View {
    @StateObject private var state = DetailState()
    public let detailsPublisher: AnyPublisher<[String: String], Never>
    public let loadingPublisher: AnyPublisher<Bool, Never>
    public let onAttributeTap: (AttributeDetail) -> Void
    
    public var body: some View {
        DetailView(
            details: state.details,
            isLoading: state.isLoading,
            onAttributeTap: onAttributeTap
        )
        .onAppear {
            detailsPublisher
                .assign(to: &state.$details)
            loadingPublisher
                .assign(to: &state.$isLoading)
        }
    }
}


@available(iOS 18, macOS 14, *)
struct DetailView: View {
    var details: [String: String] = [:]
    var isLoading: Bool = false
    let onAttributeTap: (AttributeDetail) -> Void
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            } else if !details.isEmpty {
                DetailsListView(
                    details: details,
                    onAttributeTap: onAttributeTap
                )
            }
        }
    }
}

@available(iOS 18, macOS 14, *)
class DetailState: ObservableObject {
    @Published var details: [String: String] = [:]
    @Published var isLoading: Bool = false
}

@available(iOS 18, macOS 14, *)
struct DetailsListView: View {
    let details: [String: String]
    let onAttributeTap: (AttributeDetail) -> Void
    
    var body: some View {
        List {
            ForEach(Array(details.sorted(by: { $0.key < $1.key })), id: \.key) { key, value in
                DetailRow(
                    title: key,
                    value: value,
                    onTap: {
                        onAttributeTap(AttributeDetail(title: key, value: value))
                    }
                )
            }
        }
        #if os(iOS)
        .listStyle(.insetGrouped)
        #else
        .listStyle(.plain)  // fallback style for other platforms
        #endif
    }
}

@available(iOS 18, macOS 14, *)
struct DetailRow: View {
    let title: String
    let value: String?
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Spacer()
            Text(value ?? "Unknown")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())  // Makes the entire row tappable
        .onTapGesture {
            onTap()
        }
    }
}
