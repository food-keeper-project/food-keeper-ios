//
//  Category.swift
//  Domain
//
//  Created by 박성민 on 2/3/26.
//

import Foundation

public struct Category: Hashable {
    public let id: Int64
    public let name: String
    
    public init(id: Int64, name: String) {
        self.id = id
        self.name = name
    }
}

