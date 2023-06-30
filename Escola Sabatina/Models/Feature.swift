//
//  Feature.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Feature: Codable {
    let name: String
    let title: String
    let description: String
    let image: URL
    
    enum CodingKeys: CodingKey {
        case name
        case title
        case description
        case image
    }
}


