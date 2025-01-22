//
//  TabbedListView.swift
//  otus_dz2
//
//  Created by Ruslan Sabirov on 21/01/25.
//
import SwiftUI
import Combine

@available(iOS 18, macOS 14, *)
public struct TabbedListView: View {
    @Binding public var selectedTab: TabType
    public let itemsPublisher: AnyPublisher<[(id: String, title: String)], Never>
    public let loadingPublisher: AnyPublisher<Bool, Never>
    public let loadingMorePublisher: AnyPublisher<Bool, Never>
    public let hasMorePublisher: AnyPublisher<Bool, Never>
    public let onItemTap: (ItemNavigation) -> Void
    public let onLoadMore: () async -> Void
    public let onLoad: () async -> Void
    
    public var body: some View {
        VStack {
            Picker("Options", selection: $selectedTab) {
                ForEach(TabType.allCases, id: \.self) { tab in
                    Text(tab.title)
                        .tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            .onChange(of: selectedTab) { oldValue, newValue in
                Task {
                    await onLoad()
                }
            }
            
            switch selectedTab {
            case .people, .planets, .starships:
                GenericListContainerView(
                    itemsPublisher: itemsPublisher,
                    loadingPublisher: loadingPublisher,
                    loadingMorePublisher: loadingMorePublisher,
                    hasMorePublisher: hasMorePublisher,
                    onItemTap: onItemTap,
                    onLoadMore: {
                        Task {
                            await onLoadMore()
                        }
                    },
                    type: selectedTab.rawValue
                )
                .onAppear {
                    Task {
                        await onLoad()
                    }
                }
            }
        }
    }
}
