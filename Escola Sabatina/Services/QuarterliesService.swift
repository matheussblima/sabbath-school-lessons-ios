//
//  QuarterliesService.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 30/06/23.
//

import Foundation
import Alamofire

typealias QuarterliesServiceResponse = (Swift.Result<[Quarterly]?, DataError>) -> Void

protocol QuarterliesServiceProtocol {
    func getQuarterlies(language: Language, completion: @escaping QuarterliesServiceResponse)
}

class QuarterliesService: QuarterliesServiceProtocol {
    func getQuarterlies(language: Language, completion: @escaping QuarterliesServiceResponse) {
        AF.request(Constants.API.quarterliesUrl(languageCode: language.code))
            .validate()
            .responseDecodable(of: [Quarterly].self) { response in
                switch response.result {
                case .success(let quarterlies):
                    completion(.success(quarterlies))
                case .failure(let error):
                    print(error)
                    completion(.failure(.netWorkingError(error.localizedDescription)))
                }
            }
    }
}
