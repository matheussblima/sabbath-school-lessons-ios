//
//  Bible.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Bible: Codable {
    let name: String
    let verses: [String: String]?
    
    enum CodingKeys: CodingKey {
        case name
        case verses
    }
}
