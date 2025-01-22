//
//  StarWarsUI.swift
//  StarWarsUI
//
//  Created by Ruslan Sabirov on 22/01/25.
//


import SwiftUI
import Combine

@available(iOS 18, macOS 14, *)
public struct SWUI {
    public init() {}
    
    @MainActor
    public static func tabbedListView(
        selectedTab: Binding<TabType>,
        itemsPublisher: AnyPublisher<[(id: String, title: String)], Never>,
        loadingPublisher: AnyPublisher<Bool, Never>,
        loadingMorePublisher: AnyPublisher<Bool, Never>,
        hasMorePublisher: AnyPublisher<Bool, Never>,
        onItemTap: @escaping (ItemNavigation) -> Void,
        onLoadMore: @escaping () async -> Void,
        onLoad: @escaping () async -> Void
    ) -> some View {
        TabbedListView(
            selectedTab: selectedTab,
            itemsPublisher: itemsPublisher,
            loadingPublisher: loadingPublisher,
            loadingMorePublisher: loadingMorePublisher,
            hasMorePublisher: hasMorePublisher,
            onItemTap: onItemTap,
            onLoadMore: onLoadMore,
            onLoad: onLoad
        )
    }
    
    @MainActor
    public static func detailContainer(
        detailsPublisher: AnyPublisher<[String: String], Never>,
        loadingPublisher: AnyPublisher<Bool, Never>,
        onAttributeTap: @escaping (AttributeDetail) -> Void
    ) -> some View {
        DetailContainerView(
            detailsPublisher: detailsPublisher,
            loadingPublisher: loadingPublisher,
            onAttributeTap: onAttributeTap
        )
    }
    
    @MainActor
    public static func personAttributeDetail(
        title: String,
        value: String?
    ) -> some View {
        PersonAttributeDetailView(
            title: title,
            value: value
        )
    }
}
