//
//  DaysViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation

protocol DayViewModelDelegate: AnyObject {
    func didGetDays(_ days: [Day]?, error: DataError?)
}

class DayViewModel: MulticastDelegate<DayViewModelDelegate> {
    let daysService = DayService()
    var days: [Day]?
   
    func getDays(idQuartely: String, languageCode: String, idLesson: String) {
        daysService.getDays(idQuartely: idQuartely, languageCode: languageCode, idLesson: idLesson) { [self] result in
            switch result {
            case .success(let days):
                self.days = days
                invokeForEachDelegate { $0.didGetDays(days, error: nil) }
            case .failure(let error):
                invokeForEachDelegate { $0.didGetDays(nil, error: .netWorkingError(error.localizedDescription)) }
            }
        }
    }
}

