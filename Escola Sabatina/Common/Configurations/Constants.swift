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
        static let baseUrl: String = "https://sabbath-school-stage.adventech.io/api/v1"
        static let languagesUrl: String = "\(baseUrl)/languages/index.json"
        static func quarterliesUrl(languageCode: String) -> String { "\(baseUrl)/\(languageCode)/quarterlies/index.json" }
    }
}

