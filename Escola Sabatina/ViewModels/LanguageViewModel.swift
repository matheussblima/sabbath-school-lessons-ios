//
//  LanguageViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 28/06/23.
//

import Foundation

protocol LanguageViewModelDelegate: AnyObject {
    func didGetLanguages(_ languages: [Language]?, error: DataError?)
}

class LanguageViewModel {
    let languagesService = LanguagesService()
    var selectedLanguage: Language?
    weak var delegate: LanguageViewModelDelegate?
    
    func getLanguages() {
        languagesService.getLanguages { [self] result in
            switch result {
            case .success(let languages):
                selectLanguage(languages)
                delegate?.didGetLanguages(languages, error: nil)
            case .failure(let error):
                delegate?.didGetLanguages(nil, error: error)
            }
        }
    }
    
    private func selectLanguage(_ languages: [Language]?) {
        guard let languages = languages else {
            return
        }
        
        let selectedLanguage = languages.first { $0.name == "Portuguese" }
        self.selectedLanguage = selectedLanguage ?? languages.first
    }
    
}
