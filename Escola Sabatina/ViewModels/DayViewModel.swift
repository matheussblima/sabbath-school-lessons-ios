//
//  DaysViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation

protocol DayViewModelDelegate: AnyObject {
    func didGetDays(_ dayResponse: GetDayResponse?, error: DataError?)
}

class DayViewModel: MulticastDelegate<DayViewModelDelegate> {
    let daysService = DayService()
    var dayResponse: GetDayResponse?
   
    func getDays(idQuartely: String, languageCode: String, idLesson: String) {
        daysService.getDays(idQuartely: idQuartely, languageCode: languageCode, idLesson: idLesson) { [self] result in
            switch result {
            case .success(let dayResponse):
                self.dayResponse = dayResponse
                invokeForEachDelegate { $0.didGetDays(dayResponse, error: nil) }
            case .failure(let error):
                invokeForEachDelegate { $0.didGetDays(nil, error: .netWorkingError(error.localizedDescription)) }
            }
        }
    }
}

