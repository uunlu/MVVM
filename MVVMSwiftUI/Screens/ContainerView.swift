//
//  ContainerView.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import SwiftUI

struct ContainerView: View {
    @State var name: String = ""
    @State var email: String = ""
    var viewModel = ContainerViewModel()

    var body: some View {
        VStack {
            Text(name)
            Text(email)
        }
        .onAppear{
            viewModel.onChange = update
            viewModel.load()
        }
    }
    
    private func update(_ name: String, _ email: String) {
        self.name = name
        self.email = email
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
