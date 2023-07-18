//
//  Configurations.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 22/06/23.
//

import Foundation

struct Constants {
    static let appName: String = "Sabbath School".localized
    
    struct API {
        static let baseUrl: String = "https://sabbath-school-stage.adventech.io/api/v2"
        static let languagesUrl: String = "\(baseUrl)/languages/index.json"
        static func quarterliesUrl(languageCode: String) -> String { "\(baseUrl)/\(languageCode)/quarterlies/index.json" }
        static func lessonsURL(idQuartely: String, languageCode: String) -> String {
            "\(baseUrl)/\(languageCode)/quarterlies/\(idQuartely)/lessons/index.json"
        }
        static func daysURL(idQuartely: String, languageCode: String, idLesson: String) -> String {
            "\(baseUrl)/\(languageCode)/quarterlies/\(idQuartely)/lessons/\(idLesson)/index.json"
        }
        static func readURL(idQuartely: String, languageCode: String, idLesson: String, idDay: String) -> String {
            "\(baseUrl)/\(languageCode)/quarterlies/\(idQuartely)/lessons/\(idLesson)/days/\(idDay)/read/index.json"
        }
    }
}

