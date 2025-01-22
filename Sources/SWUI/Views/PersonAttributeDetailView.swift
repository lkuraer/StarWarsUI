//
//  PersonAttributeDetailView.swift
//  otus_dz2
//
//  Created by Ruslan Sabirov on 07/01/25.
//

import SwiftUI

@available(iOS 18, macOS 14, *)
public struct PersonAttributeDetailView: View {
    public let title: String
    public let value: String?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
            Text(value ?? "Unknown")
                .font(.body)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
