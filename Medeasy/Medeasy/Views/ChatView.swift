//
//  ChatView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 31.07.2025.
//

import SwiftUI

struct ChatView: View {
    
    @State private var question: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            
            RoundedRectangle(cornerRadius: 5)
                    .fill(.ultraThinMaterial)
                    .frame(height: 120)
                    .zIndex(1)
                
                HStack {
                    Text("MedAI")
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .foregroundStyle(.indigo)
                        .padding(.top, 55)
                        .padding(.leading, 90)
                    
                    
                    Spacer()
                    
                    
                    
                    Text("KS")
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .foregroundStyle(.lightBlue)
                        .padding(12)
                        .background(Circle().fill(Color.indigo))
                        .shadow(radius: 5)
                        .padding(.top, 55)
                        .padding(.trailing, 30)
                    
                }
                .zIndex(1)
                
                
            ScrollViewReader { proxy in
                ScrollView {
                    
                    VStack(spacing: 25) {
                        
                        //MARK: - AI answer
                        
                        HStack(spacing: 20) {
                            Text("AI")
                                .font(.system(size: 17, weight: .bold, design: .default))
                                .foregroundStyle(.lightBlue)
                                .padding(10)
                                .background(Circle().fill(Color.teal))
                                
                            
                            
                            
                            Text("How can I help you today?")
                                .foregroundStyle(.white)
                                .padding(20)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color.teal))
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                            
                            
                            Spacer()
                            
                            
                        }.padding(.horizontal, 20)
                            
                        
                        
                        //MARK: - User input
                        
                        HStack(spacing: 20) {
                            Spacer()
                            
                            Text("I am feeling ill. I have a 38 degrees temperature and a cough.")
                                .foregroundStyle(.white)
                                .padding(20)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color.indigo))
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                            
                            Text("KS")
                                .font(.system(size: 17, weight: .bold, design: .default))
                                .foregroundStyle(.lightBlue)
                                .padding(10)
                                .background(Circle().fill(Color.indigo))
                            
                            
                        }.padding(.horizontal, 20)
                        
                        
                        
                        //MARK: - AI answer
                        
                        HStack(spacing: 20) {
                            Text("AI")
                                .font(.system(size: 17, weight: .bold, design: .default))
                                .foregroundStyle(.lightBlue)
                                .padding(10)
                                .background(Circle().fill(Color.teal))
                                
                            
                            
                            
                            Text("Drink a lot of warm water and keep yourself warm. Do not try to work.")
                                .foregroundStyle(.white)
                                .padding(20)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color.teal))
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                            
                            
                            Spacer()
                            
                            
                        }.padding(.horizontal, 20)
                        
                        
                        
                        Spacer()
                        
                        
                        
                        
                    }.padding(.top, 140)
                    
                }.safeAreaInset(edge: .bottom) {
                    HStack {
                        TextField("Ask your question", text: $question)
                            .padding(.horizontal)
                        
                        Button(){
                            
                        } label : {
                            Image(systemName: "arrow.up")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(12)
                                .foregroundStyle(.blueish)
                                .background(Circle().fill(Color.lightBlue))
                        }
                        .padding(.horizontal)
                        
                    }.padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 55)
                                .fill(.ultraThinMaterial)
                                .padding([.leading, .trailing], 20)
                        )
                    
                }.padding(.bottom, 30)
                    .onAppear()
            }
            
           
            
            
        }.ignoresSafeArea()
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    ChatView()
}
