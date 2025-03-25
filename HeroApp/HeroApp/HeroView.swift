//
//  HeroView.swift
//  HeroApp
//
//  Created by Куаныш Спандияр on 25.03.2025.
//

import SwiftUI

struct HeroView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Hero List")
                .font(.largeTitle)
            
            Divider()
                .padding(.bottom, 16)
            
            listOfHeroes()
            Spacer()
            
        }
        .task {
            await viewModel.fetchHeroes()
        }
    }
}


extension HeroView {
    @ViewBuilder
    private func listOfHeroes() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.heroes) { model in
                    heroCard(model: model)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
    
    @ViewBuilder
    private func heroCard(model: Model) -> some View {
        HStack {
            AsyncImage(url: model.heroImage) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 16)
                    
                    
                default:
                    Color.gray
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 16)
                    
                }
            }
            
            VStack(alignment: .leading) {
                Text(model.title)
                Text(model.description)
            }
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            print("Tapped \(model.id)")
            viewModel.routeToDetail(by: model.id)
        }
    }
    
}


