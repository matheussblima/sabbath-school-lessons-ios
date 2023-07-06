//
//  QuarterlyViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 30/06/23.
//

import Foundation

protocol QuarterlyViewModelDelegate: AnyObject {
    func didGetQuarterlies(_ quarterlyViewModel: QuarterlyViewModel, error: DataError?)
}

class QuarterlyViewModel {
    let quarterliesService = QuarterliesService()
    private(set) var quarterlies: [Quarterly] = []
    private(set) var selectedQuarterly: QuarterlyGroup?
    var quarterliesGroup: [QuarterlyGroup] {
        let quarterlyGroup: Set<QuarterlyGroup> = Set(quarterlies.compactMap({ $0.quarterlyGroup }))
        return Array(quarterlyGroup).sorted { itemA, itemB in
            itemA.order < itemB.order
        }
    }
    
    
    weak var delegate: QuarterlyViewModelDelegate?
    
    func getQuarterlies(language: Language) {
        quarterliesService.getQuarterlies(language: language) { [self] response in
            switch response {
            case .success(let quarterlies):
                if let quarterlies = quarterlies {
                    self.quarterlies = quarterlies
                    
                    if let quarterlyGroup = quarterlies.first?.quarterlyGroup {
                        selectQuarterlyGroup(quarterlyGroup)
                    }
                }
                delegate?.didGetQuarterlies(self, error: nil)
                
            case .failure(let error):
                delegate?.didGetQuarterlies(self, error: error)
            }
        }
    }
    
    func selectQuarterlyGroup(_ quarterlyGroup: QuarterlyGroup) {
        guard let index = quarterliesGroup.firstIndex(where: { $0 == quarterlyGroup }) else {
            selectedQuarterly = quarterliesGroup.first
            return
        }
        
        selectedQuarterly = quarterlyGroup
    }
}
