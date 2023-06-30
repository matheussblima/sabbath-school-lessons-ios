//
//  LanguageViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 28/06/23.
//

import Foundation

protocol LanguageViewModelDelegate: AnyObject {
    func didGetLanguages(_ languages: [Language]?, error: DataError?)
    func didSelectedLanguage(_ language: Language)
}

class LanguageViewModel {
    let languagesService = LanguagesService()
    var languages: [Language]?
    
    weak var delegate: LanguageViewModelDelegate?
    
    private(set) var selectedLanguage: Language = Language(name: "Portuguese", code: "pt")
   
    
    func getLanguages() {
        languagesService.getLanguages { [self] result in
            switch result {
            case .success(let languages):
                selectLanguageDefault(languages)
                self.languages = languages
                delegate?.didGetLanguages(languages, error: nil)
            case .failure(let error):
                delegate?.didGetLanguages(nil, error: error)
            }
        }
    }
    
    private func selectLanguageDefault(_ languages: [Language]?) {
        guard let languages = languages else {
            return
        }
        
        let selectedLanguage = languages.first { $0.code == "pt" }
        self.selectedLanguage = selectedLanguage ?? languages.first!
    }
    
    func selectLanguage(_ language: Language) {
        delegate?.didSelectedLanguage(language)
        selectedLanguage = language
    }
    
}
