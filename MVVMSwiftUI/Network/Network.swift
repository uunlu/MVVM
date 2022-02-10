//
//  Network.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import Foundation
import Combine

protocol Network {
    var decoder: JSONDecoder { get set }
}

extension Network {
    func fetch<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryCompactMap { result in
                guard let response = result.response as? HTTPURLResponse else {
                    throw ApiError.network
                }
                guard 200..<300 ~= response.statusCode else {
                    switch response.statusCode {
                    case 400:
                        throw ApiError.unauthorized
                    default:
                        throw ApiError.invalid(status: response.statusCode, message: response.description)
                    }
                }
                
                do {
                    return try self.decoder.decode(T.self, from: result.data)
                }catch {
                    throw error
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

enum ApiError: Error {
    case network
    case unauthorized
    case invalid(status: Int, message: String)
}
