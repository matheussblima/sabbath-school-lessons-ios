//
//  String.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 23/06/23.
//

import Foundation


extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
