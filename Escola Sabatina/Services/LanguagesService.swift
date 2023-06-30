//
//  LanguagesService.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 21/06/23.
//

import Foundation
import Alamofire

typealias LanguageServiceResponse = (Swift.Result<[Language]?, DataError>) -> Void

protocol LanguageServiceProtocol {
    func getLanguages(completion: @escaping LanguageServiceResponse)
}

class LanguagesService: LanguageServiceProtocol {
    func getLanguages(completion: @escaping LanguageServiceResponse) {
        AF.request(Constants.API.languagesUrl)
            .validate()
            .responseDecodable(of: [Language].self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(.netWorkingError(error.localizedDescription)))
                case .success(let language):
                    completion(.success(language))
                }
            }
    }
}
