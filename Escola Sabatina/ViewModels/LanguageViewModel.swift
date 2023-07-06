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

class LanguageViewModel: MulticastDelegate<LanguageViewModelDelegate> {
    let languagesService = LanguagesService()
    var languages: [Language]?
    
    private(set) var selectedLanguage: Language = Language(name: "Portuguese", code: "pt")
   
    func getLanguages() {
        languagesService.getLanguages { [self] result in
            switch result {
            case .success(let languages):
                selectLanguageDefault(languages)
                self.languages = languages
                invokeForEachDelegate { $0.didGetLanguages(languages, error: nil) }
            case .failure(let error):
                invokeForEachDelegate { $0.didGetLanguages(nil, error: .netWorkingError(error.localizedDescription)) }
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
        invokeForEachDelegate { $0.didSelectedLanguage(language) }
        selectedLanguage = language
    }
    
}
