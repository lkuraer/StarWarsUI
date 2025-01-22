//
//  ListViews.swift
//  otus_dz2
//
//  Created by Ruslan Sabirov on 07/01/25.
//

import SwiftUI
import Combine

@available(iOS 18, macOS 14, *)
struct GenericListContainerView: View {
    @StateObject private var state = ListState()
    let itemsPublisher: AnyPublisher<[(id: String, title: String)], Never>
    let loadingPublisher: AnyPublisher<Bool, Never>
    let loadingMorePublisher: AnyPublisher<Bool, Never>
    let hasMorePublisher: AnyPublisher<Bool, Never>
    let onItemTap: (ItemNavigation) -> Void
    let onLoadMore: () -> Void
    let type: String
    
    public var body: some View {
        GenericListView(
            items: state.items,
            isLoading: state.isLoading,
            isLoadingMore: state.isLoadingMore,
            hasMore: state.hasMore,
            type: type,
            onItemTap: onItemTap,
            onLoadMore: onLoadMore
        )
        .onAppear {
            itemsPublisher
                .assign(to: &state.$items)
            loadingPublisher
                .assign(to: &state.$isLoading)
            loadingMorePublisher
                .assign(to: &state.$isLoadingMore)
            hasMorePublisher
                .assign(to: &state.$hasMore)
        }
    }
}

@available(iOS 18, macOS 14, *)
struct GenericListView: View {
    let items: [(id: String, title: String)]
    let isLoading: Bool
    let isLoadingMore: Bool
    let hasMore: Bool
    let type: String
    let onItemTap: (ItemNavigation) -> Void
    let onLoadMore: () -> Void
    
    var body: some View {
        ZStack {
            List {
                ForEach(items, id: \.id) { item in
                    Button(action: {
                        onItemTap(ItemNavigation(id: item.id, type: type))
                    }) {
                        HStack {
                            Text(item.title)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                    .onAppear {
                        if item.id == items.last?.id && !isLoadingMore && hasMore {
                            onLoadMore()
                        }
                    }
                }

                if isLoadingMore {
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(.circular)
                        Text("Loading...")
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            
            if items.isEmpty && isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.1))
            }
        }
    }
}

@available(iOS 18, macOS 14, *)
class ListState: ObservableObject {
    @Published var items: [(id: String, title: String)] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var hasMore: Bool = true
}

