//
//  Lesson.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation


struct Lesson: Codable {
    let title: String
    let startDate: Date
    let endDate: String
    let id: String
    let index: String
    let fullPath: URL
    let pdfOnly: Bool
    let cover: URL?
    
    enum CodingKeys: String, CodingKey {
        case title
        case startDate = "start_date"
        case endDate = "end_date"
        case id
        case index
        case fullPath = "full_path"
        case pdfOnly
        case cover
    }
}
