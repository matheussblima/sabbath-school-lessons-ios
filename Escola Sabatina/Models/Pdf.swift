//
//  Pdf.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Pdf: Codable {
    let src: URL
    let title: String
    let target: String
    let id: String
    let startDate: String
    let endDate: String
    
    enum CodingKeys:String, CodingKey {
        case src
        case title
        case target
        case id
        case startDate = "start_date"
        case endDate = "end_date"
    }
}
