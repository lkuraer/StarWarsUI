//
//  SWTabType.swift
//  otus_dz2
//
//  Created by Ruslan Sabirov on 07/01/25.
//

@available(iOS 18, macOS 14, *)
public enum TabType: String, CaseIterable {
    case people = "people"
    case planets = "planets"
    case starships = "starships"
    
    public var title: String {
        return rawValue.capitalized
    }
}

