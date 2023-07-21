//
//  DayService.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 14/07/23.
//

import Foundation
import Alamofire

typealias getDayServiceResponse = (Swift.Result<GetDayResponse?, DataError>) -> Void

protocol DayServiceProtocol {
    func getDays(idQuartely: String, languageCode: String, idLesson: String, completion: @escaping getDayServiceResponse)
}

struct GetDayResponse: Codable {
    let lesson: Lesson
    let days: [Day]
    let pdfs: [Pdf]
}

class DayService: DayServiceProtocol {
    func getDays(idQuartely: String, languageCode: String, idLesson: String, completion: @escaping getDayServiceResponse) {
        AF.request(Constants.API.daysURL(idQuartely: idQuartely, languageCode: languageCode, idLesson: idLesson))
            .validate()
            .responseDecodable(of: GetDayResponse.self) { response in
                switch response.result {
                case .success(let responseDays):
                    completion(.success(responseDays))
                case .failure(let error):
                    completion(.failure(.netWorkingError(error.localizedDescription)))
                }
            }
    }
}
