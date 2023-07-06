//
//  QuarterlyGroup.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct QuarterlyGroup: Codable, Hashable {
    let name: String
    let order: Int
    
    enum CodingKeys: CodingKey {
        case name
        case order
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
