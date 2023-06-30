//
//  Credit.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Credit: Codable {
    let name: String
    let value: String
    
    enum CodingKeys: CodingKey {
        case name
        case value
    }
}
