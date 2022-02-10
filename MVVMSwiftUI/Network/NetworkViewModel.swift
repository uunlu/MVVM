//
//  NetworkViewModel.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import Foundation
import Combine

protocol NetworkViewModel: ObservableObject {
    associatedtype NetworkResource: Decodable
    var bag: Set<AnyCancellable> { get set }
    var resource: Resource<NetworkResource> { get set }
    var network: Network { get set }
}

// MARK: - Default Implementation

extension NetworkViewModel {
    func fetch(request: URLRequest) {
        (network.fetch(request: request) as AnyPublisher<NetworkResource, Error>)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.resource = .error(error)
                    print(error.localizedDescription)
                default:
                    break
                }
            }, receiveValue: { [weak self] result in
                self?.resource = .success(result)
            })
            .store(in: &bag)
    }
}
