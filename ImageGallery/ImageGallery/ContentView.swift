//
//  ContentView.swift
//  ImageGallery
//
//  Created by Куаныш Спандияр on 03.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.images) { model in
                        model.image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
        
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            
            Button("Get 5 Images") {
                viewModel.getImages()
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
