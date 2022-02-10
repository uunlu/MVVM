//
//  ContainerView.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import Foundation
import Combine

class ContainerViewModel: ObservableObject {
    @Published var name: String = ""
    @Published  var email: String = ""
    
    func load() {
        RunLoop.current.run(until: Date().addingTimeInterval(1))
        print("updating")
        name = "Messi"
        email = "messi@fcbarcelona.com"
    }
}
