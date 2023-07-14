//
//  DayService.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation
import Alamofire

typealias getDayServiceResponse = (Swift.Result<[Day]?, DataError>) -> Void

protocol DayServiceProtocol {
    func getDays(idQuartely: String, languageCode: String, idLesson: String, completion: @escaping getDayServiceResponse)
}

struct GetDayResponse: Codable {
    let lesson: Lesson
    let days: [Day]
}

class DayService: DayServiceProtocol {
    func getDays(idQuartely: String, languageCode: String, idLesson: String, completion: @escaping getDayServiceResponse) {
        AF.request(Constants.API.daysURL(idQuartely: idQuartely, languageCode: languageCode, idLesson: idLesson))
            .validate()
            .responseDecodable(of: GetDayResponse.self) { response in
                switch response.result {
                case .success(let responseDays):
                    completion(.success(responseDays.days))
                case .failure(let error):
                    completion(.failure(.netWorkingError(error.localizedDescription)))
                }
            }
    }
}
