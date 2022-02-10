//
//  ContainerView.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import Foundation

class ContainerViewModel {
    var name: String = ""
    var email: String = ""
    var onChange: ((String, String)->Void)?
    
    func load() {
        RunLoop.current.run(until: Date().addingTimeInterval(1))
        print("updating")
        name = "Messi"
        email = "messi@fcbarcelona.com"
        onChange?(name, email)
    }
}
