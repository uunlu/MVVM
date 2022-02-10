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
            Text("MVVM Example").font(.headline)
            Spacer()
            
            viewModel.resource.isLoading{
                Text("Loading...")
            }
            viewModel.resource.hasResource { PersonView(model: $0) }
            Spacer()
            viewModel.resource.hasError { error in
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .bold()
            }
            
        }
        .padding()
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
