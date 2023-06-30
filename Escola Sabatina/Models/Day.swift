//
//  Day.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Day: Codable {
    let title: String
    let date: String
    let id: String
    let index: String
    let path: String
    let fullPath: URL
    let readPath: String
    let fullReadPath: URL
    
    enum CodingKeys:String, CodingKey {
        case title
        case date
        case id
        case index
        case path
        case fullPath = "full_path"
        case readPath = "read_path"
        case fullReadPath = "full_read_path"
    }
}
