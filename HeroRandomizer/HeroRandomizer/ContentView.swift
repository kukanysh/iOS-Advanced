//
//  ContentView.swift
//  HeroRandomizer
//
//  Created by Куаныш Спандияр on 02.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            //MARK: - Hero Image
            AsyncImage(url: viewModel.selectedHero?.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width, height: 450)
                        .background(Color.gray.opacity(0.3))
                        .ignoresSafeArea()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, alignment: .top)
                        .ignoresSafeArea()
                    
                case .failure:
                    Color.red
                        .frame(width: UIScreen.main.bounds.width, height: 450)
                        .ignoresSafeArea()
                    
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 450, alignment: .top)
            
            Spacer()
            
            //MARK: -  Hero Info Card
            ZStack {
                RoundedRectangle(cornerRadius: 65)
                    .fill(Color.white)
                    .shadow(radius: 5)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
                
                VStack(spacing: 12) {
                    
                    Spacer()
                    
                    Text(viewModel.selectedHero?.name ?? "Loading...")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text(viewModel.selectedHero?.fullName ?? "Unknown Identity")
                        .foregroundColor(.gray)
                        .font(.headline)
                    
                    Divider()
                    
                    InfoRow(title: "Gender", value: viewModel.selectedHero?.gender)
                    InfoRow(title: "Race", value: viewModel.selectedHero?.race)
                    InfoRow(title: "Height", value: viewModel.selectedHero?.height)
                    InfoRow(title: "Weight", value: viewModel.selectedHero?.weight)
                    InfoRow(title: "Place of Birth", value: viewModel.selectedHero?.placeOfBirth)
                    InfoRow(title: "First Appearance", value: viewModel.selectedHero?.firstAppearance)
                    InfoRow(title: "Publisher", value: viewModel.selectedHero?.publisher)
                    InfoRow(title: "Alignment", value: viewModel.selectedHero?.alignment)
                    InfoRow(title: "Occupation", value: viewModel.selectedHero?.occupation)

                    Spacer()
                    
                    
                    //MARK: -  Roll Hero Button
                    Button {
                        Task {
                            await viewModel.fetchHero()
                        }
                    } label: {
                        Text("Roll Hero")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 160)
                            .background(Color.indigo)
                            .cornerRadius(12)
                    }
                    .frame(alignment: .bottom)
                    .padding(.bottom, 80)
                    
                    
                    
                }
                .padding()
                
            }
            .padding(.top, -60)
            
           
        }
    }
}

//MARK: -  Reusable Info Row
struct InfoRow: View {
    let title: String
    let value: String?
    
    var body: some View {
        HStack {
            Text(title + ":")
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value ?? "Unknown")
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    let viewModel = ViewModel()
    ContentView(viewModel: viewModel)
}
