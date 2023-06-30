//
//  Quartelies.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Quarterly: Codable {
    let title: String
    let description: String
    let humanDate: String
    let startDate: String
    let endDate: String
    let colorPrimary: String?
    let colorPrimaryDark: String?
    let splash: URL?
    let credits: [Credit]
    let lang: String
    let id: String
    let index: String
    let path: String
    let fullPath: URL
    let introduction: String
    let feature: [Feature]
    let quarterlyGroup: [QuarterlyGroup]?
    let cover: URL
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case humanDate = "human_date"
        case startDate = "start_date"
        case endDate = "end_date"
        case colorPrimary = "color_primary"
        case colorPrimaryDark = "color_primary_dark"
        case splash
        case credits
        case lang
        case id
        case index
        case path
        case fullPath = "full_path"
        case introduction
        case feature
        case quarterlyGroup = "quarterly_group"
        case cover
    }
}
