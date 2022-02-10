//
//  PersonView.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import SwiftUI

struct PersonView: View {
    let model: Person
    var body: some View {
        VStack {
            Text("Name: \(model.name)")
            Text("Email: \(model.email)")
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(model: .init(name: "Messi", email: "messi@me.com"))
    }
}
