//
//  Languages.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 21/06/23.
//

import Foundation

struct Language: Codable, Equatable  {
    let name: String
    let code: String
    
    enum CodingKeys: CodingKey {
        case name
        case code
    }
    
    static func == (lsh: Language, rsh: Language) -> Bool {
        return lsh.code == rsh.code
    }
}
