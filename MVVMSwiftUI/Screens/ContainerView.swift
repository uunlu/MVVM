//
//  ContainerView.swift
//  MVVMSwiftUI
//
//  Created by Ugur Unlu on 2/10/22.
//

import SwiftUI

struct ContainerView: View {
    @StateObject var viewModel = ContainerViewModel()

    var body: some View {
        VStack {
            Text(viewModel.name)
            Text(viewModel.email)
        }
        .onAppear{
            viewModel.load()
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
