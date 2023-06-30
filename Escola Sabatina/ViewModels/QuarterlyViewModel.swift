//
//  QuarterlyViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 30/06/23.
//

import Foundation

protocol QuarterlyViewModelDelegate: AnyObject {
    func didGetQuarterlies(quarterlies: [Quarterly]?, error: DataError?)
}

class QuarterlyViewModel {
    let quarterliesService = QuarterliesService()
    weak var delegate: QuarterlyViewModelDelegate?
    
    func getQuarterlies(language: Language) {
        quarterliesService.getQuarterlies(language: language) { [self] response in
            switch response {
            case .success(let quarterlies):
                delegate?.didGetQuarterlies(quarterlies: quarterlies, error: nil)
            case .failure(let error):
                delegate?.didGetQuarterlies(quarterlies: nil, error: error)
            }
        }
    }
}
