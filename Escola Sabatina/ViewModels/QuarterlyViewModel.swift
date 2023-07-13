//
//  QuarterlyViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 30/06/23.
//

import Foundation

protocol QuarterlyViewModelDelegate: AnyObject {
    func didGetQuarterlies(_ quarterlyViewModel: QuarterlyViewModel, error: DataError?)
    func didSelectedQuarterly(_ quarterlyViewModel: QuarterlyViewModel)
}

class QuarterlyViewModel: MulticastDelegate<QuarterlyViewModelDelegate> {
    let quarterliesService = QuarterliesService()
    private(set) var quarterlies: [Quarterly] = []
    private(set) var selectedQuarterly: QuarterlyGroup?
    var quarterliesGroup: [QuarterlyGroup] = []
    
    func getQuarterlies(language: Language) {
        quarterliesService.getQuarterlies(language: language) { [self] response in
            switch response {
            case .success(let quarterlies):
                if let quarterlies = quarterlies {
                    self.quarterlies = quarterlies
                    setQuarterliesGroup(quarterlies)
                    
                    if let quarterlyGroup = quarterlies.first?.quarterlyGroup {
                        selectQuarterlyGroup(quarterlyGroup)
                    }
                }
                invokeForEachDelegate { $0.didGetQuarterlies(self, error: nil) }
                
            case .failure(let error):
                invokeForEachDelegate { $0.didGetQuarterlies(self, error: error) }
            }
        }
    }
    
     func selectQuarterlyGroup(_ quarterlyGroup: QuarterlyGroup) {
         guard let index = quarterliesGroup.firstIndex(where: { $0.name == quarterlyGroup.name }) else {
            selectedQuarterly = quarterliesGroup.first
            return
        }
         
         for (index, _) in quarterliesGroup.enumerated() {
             quarterliesGroup[index].isSelected = false
         }
         quarterliesGroup[index].isSelected = true
         selectedQuarterly = quarterliesGroup[index]
    
        invokeForEachDelegate { $0.didSelectedQuarterly(self) }
    }
    
    private func setQuarterliesGroup(_ quarterlies: [Quarterly]) {
        let quarterlyGroup: Set<QuarterlyGroup> = Set(quarterlies.compactMap({ $0.quarterlyGroup }))
        quarterliesGroup = Array(quarterlyGroup).sorted { itemA, itemB in
            itemA.order < itemB.order
        }
    }
}
