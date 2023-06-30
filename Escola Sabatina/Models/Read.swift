//
//  Read.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Read: Codable {
    var id: String
    var date: String
    var index: String
    var title: String
    var bible: [Bible]
    var content: String
    
    enum CodingKeys: CodingKey {
        case id
        case date
        case index
        case title
        case bible
        case content
    }
}

