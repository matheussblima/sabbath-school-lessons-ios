//
//  ReadViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 18/07/23.
//

import Foundation

protocol ReadViewModelDelegate: AnyObject {
    func didGetRead(_ read: Read?, error: DataError?)
}

class ReadViewModel {
    let readService = ReadService()
    
    weak var delegate: ReadViewModelDelegate?
    
    func getRead(idQuartely: String, languageCode: String, idLesson: String, idDay: String) {
        readService.getRead(idQuartely: idQuartely, languageCode: languageCode, idLesson: idLesson, idDay: idDay) { [self] result in
            switch result {
            case .success(let read):
                delegate?.didGetRead(read, error: nil)
            case .failure(let error):
                delegate?.didGetRead(nil, error: error)
                
            }
        }
    }
}
