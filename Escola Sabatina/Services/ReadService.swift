//
//  ReadService.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 17/07/23.
//

import Foundation
import Alamofire

typealias getReadResponse = (Swift.Result<Read?, DataError>) -> Void

protocol ReadServiceProtocol {
    func getRead(idQuartely: String, languageCode: String, idLesson: String, idDay: String, completion: @escaping getReadResponse)
}

class ReadService: ReadServiceProtocol {
    func getRead(idQuartely: String, languageCode: String, idLesson: String, idDay: String, completion: @escaping getReadResponse) {
        AF.request(Constants.API.readURL(idQuartely: idQuartely, languageCode: languageCode, idLesson: idLesson, idDay: idDay))
            .validate()
            .responseDecodable(of: Read.self) { response in
                switch response.result {
                case .success(let read):
                    completion(.success(read))
                case .failure(let error):
                    completion(.failure(.netWorkingError(error.localizedDescription)))
                }
            }
    }
}
