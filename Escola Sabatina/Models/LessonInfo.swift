//
//  LessonInfo.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct LessonInfo: Codable {
    let lesson: Lesson
    let days: [Day]
    let pdfs: [Pdf]
    
    enum CodingKeys: CodingKey {
        case lesson
        case days
        case pdfs
    }
}
