//
//  AttributeDetail.swift
//  otus_dz2
//
//  Created by Ruslan Sabirov on 07/01/25.
//

@available(iOS 18, macOS 14, *)
public struct AttributeDetail: Hashable {
    public let title: String
    public let value: String?
    
    public init(title: String, value: String?) {
        self.title = title
        self.value = value
    }
}
