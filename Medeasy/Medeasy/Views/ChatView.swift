//
//  ChatView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 31.07.2025.
//

import SwiftUI

struct ChatView: View {
    
    @State private var question: String = ""
    
    @State private var messages: [Message] = [
        Message(role: .ai, message: "Hi! How can I help you today?"),
        Message(role: .user, message: "I feel unwell."),
        Message(role: .ai, message: "Please describe your symptoms."),
        Message(role: .user, message: "I have a headache and fever."),
        Message(role: .ai, message: "Drink a lot of warm water and lay down. You can drink Citramon to release the pain or Ibuprofen."),
        Message(role: .user, message: "What else can I do?"),
        Message(role: .ai, message: "Eat by small portions and try to drink more water. Change your clothes if you get sweaty."),
        Message(role: .user, message: "Okay, thank you so much"),
        Message(role: .ai, message: "No problem, get well soon!"),
    ]
    
    @StateObject private var keyboard = KeyboardResponder()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            RoundedRectangle(cornerRadius: 5)
                    .fill(.ultraThinMaterial)
                    .frame(height: 120)
                    .zIndex(1)
                
                HStack {
                    Text("MedAI")
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .foregroundStyle(.blueish)
                        .padding(.top, 55)
                        .padding(.leading, 100)
                    
                    
                    Spacer()
                    
                    
                     
                    Text("KS")
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .foregroundStyle(.lightBlue)
                        .padding(12)
                        .background(Circle().fill(Color.blueish))
                        .shadow(radius: 5)
                        .padding(.top, 55)
                        .padding(.trailing, 30)
                    
                }
                .zIndex(1)
                
                
            ScrollViewReader { proxy in
                ScrollView {
                    
                    VStack(spacing: 16) {
                        
                        
                        
                        ForEach(messages) { message in
                            if message.role == .user {
                                //MARK: - User input
                                
                                HStack(spacing: 20) {
                                    Spacer()
                                    
                                    Text(message.message)
                                        .foregroundStyle(.white)
                                        .padding(16)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(Color.blueish))
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                }.padding(.trailing, 20)
                                    .id(message.id)
                                
                            } else {
                                //MARK: - AI answer
                                
                                HStack(spacing: 20) {
                                        
                                    
                                    Text(message.message)
                                        .padding(16)
                                        .background(RoundedRectangle(cornerRadius: 25).fill(Color.gray).opacity(0.3))
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    
                                    Spacer()
                                    
                                    
                                }.padding(.leading, 20)
                                    .id(message.id)
                            }
                        }

               
           
                        Spacer()
                        
                        
                        
                        
                    }.padding(.top, 140)
                    .frame(maxWidth: .infinity)
                    
                }.safeAreaInset(edge: .bottom) {
                    HStack {
                        TextField("Ask your question", text: $question)
                            .padding(.horizontal)
                        
                        Button{
                            
                            if !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                let newMessage = Message(role: .user, message: question)
                                messages.append(newMessage)
                                question = ""
                            }
                            
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
                    
                }.padding(.bottom, keyboard.currentHeight == 0 ? 90 : keyboard.currentHeight)
                    .onChange(of: messages) { _ in
                        if let last = messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
            }
            
           
            
            
        }.ignoresSafeArea()
        .toolbarBackground(.hidden, for: .navigationBar)
        .hideKeyboardOnTap()
    }
}

#Preview {
    ChatView()
}
