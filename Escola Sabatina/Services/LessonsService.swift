//
//  LessonsService.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 13/07/23.
//

import Foundation
import Alamofire

typealias LessonsServiceResponse = (Swift.Result<[Lesson]?, DataError>) -> Void

protocol LessonsServiceProtocol {
    func getLessons(idQuartely: String, languageCode: String, completion: @escaping LessonsServiceResponse)
}

class LessonsService: LessonsServiceProtocol {
    func getLessons(idQuartely: String, languageCode: String, completion: @escaping LessonsServiceResponse) {
        AF.request(Constants.API.lessonsURL(idQuartely: idQuartely, languageCode: languageCode))
            .validate()
            .responseDecodable(of: [Lesson].self) { response in
                switch response.result {
                case .success(let lessons):
                    completion(.success(lessons))
                case .failure(let error):
                    completion(.failure(.netWorkingError(error.localizedDescription)))
                }
            }
    }
}
