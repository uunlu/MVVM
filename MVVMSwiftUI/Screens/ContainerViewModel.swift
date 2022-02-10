//
//  ContainerView.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import Foundation
import Combine

class ContainerViewModel: ObservableObject {
    private let network = ContainerNetworkSpy()
    @Published var resource: Resource<Person> = .pending
    
    func load() {
        bind()
        self.network.resource = .loading
        DispatchQueue.global(qos: DispatchQoS.background.qosClass).asyncAfter(deadline: .now() + 1) {
               DispatchQueue.main.async {
                   self.network.resource = .success(.init(name: "Messi", email: "messi@me.com"))
               }
            
            DispatchQueue.global(qos: DispatchQoS.background.qosClass).asyncAfter(deadline: .now() + 1) {
                DispatchQueue.main.async {
                    self.network.resource = .loading
                }
                DispatchQueue.global(qos: DispatchQoS.background.qosClass).asyncAfter(deadline: .now() + 1) {
                    DispatchQueue.main.async {
                        self.network.resource = .error(NSError(domain: "Some error occured", code: 0))
                    }
                }
            }
        }
    }
    
    func bind() {
        network.$resource
            .sink { value in
                self.resource = value
            }
            .store(in: &network.bag)
    }
}

class ContainerNetworkSpy: NetworkViewModel {
    typealias NetworkResource = Person
    var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    @Published var resource: Resource<Person> = .pending
    var network: Network = JSONNetwork()
    
}

class JSONNetwork: Network {
    var decoder: JSONDecoder = JSONDecoder()
}

struct Person: Codable {
    let name: String
    let email: String
}
