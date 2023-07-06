//
//  Quartelies.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Quarterly: Codable {
    let id: String
    let title: String
    let description: String
    let humanDate: String
    let startDate: String
    let endDate: String
    let cover: URL
    let splash: URL?
    let colorPrimary: String?
    let colorPrimaryDark: String?
    let index: String
    let path: String
    let fullPath: URL
    let lang: String
    let webURL: URL?
    let quarterlyName: String?
    let introduction: String
    let credits: [Credit]?
    let features: [Feature]?
    let quarterlyGroup: QuarterlyGroup?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case humanDate = "human_date"
        case startDate = "start_date"
        case endDate = "end_date"
        case cover
        case splash
        case colorPrimary = "color_primary"
        case colorPrimaryDark = "color_primary_dark"
        case index
        case path
        case fullPath = "full_path"
        case lang
        case webURL
        case quarterlyName
        case introduction
        case credits
        case features
        case quarterlyGroup = "quarterly_group"

    }
    
    static func == (lhs: Quarterly, rhs: Quarterly) -> Bool {
        lhs.id == rhs.id
    }
}


