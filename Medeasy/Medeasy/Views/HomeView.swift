//
//  HomeView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 09.05.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("Search", text: $searchText)
                .padding(20)
                .textFieldStyle(.roundedBorder)
                .clipShape(.capsule)
                .frame(height: 42)
                .backgroundStyle(.gray)
            
            Spacer()
                
                
            ForEach(0..<6) {_ in
                VStack {
                    HStack(spacing: 10) {
                        Image("settings")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 60, height: 60)
                        
                        
                        VStack {
                            Text("Berdikhozhaev.M")
                                .font(.custom("Poppins Bold", size: 24))
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)))
                                .multilineTextAlignment(.center)
                            
                            //Neurosurgeon
                            Text("Neurosurgeon")
                                .font(.custom("Poppins Medium", size: 18))
                                .foregroundColor(Color(#colorLiteral(red: 0.12, green: 0.4, blue: 0.66, alpha: 0.9)))
                                .multilineTextAlignment(.center)
                            
                        }
                        
                        Spacer()
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image("nav")
                        }
                        
                        Spacer()
                        
                    }.padding([.leading, .trailing], 20)
                    
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.12, green: 0.4, blue: 0.66, alpha: 0.9)))
                        .frame(height: 1)
                        .padding(.vertical)
                    
                    
                }
            }
            
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image("more")
            }
            
            ToolbarItem(placement: .principal) {
                Text("Hi, User!")
                    .font(.title2)
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HomeView()
}
