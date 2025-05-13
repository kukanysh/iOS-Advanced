//
//  FeedbackView.swift
//  Medeasy
//
//  Created by Zhaina Igenbek on 13.05.2025.
//

import SwiftUI

struct FeedbackView: View {
    @State private var feedbackText = ""
    @State private var rating = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Give feedback")
                .font(.largeTitle).bold()
            
            Text("How was your appointment?").font(.title3)
            
            HStack {
                ForEach(1...5, id: \.self) { i in
                    Image(systemName: i <= rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            rating = i
                        }
                }
            }

            Spacer()
            
            Text("Want to share more about it?")
            
            TextEditor(text: $feedbackText)
                .frame(height: 300)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))

            Button(action: {
                // handle feedback submit
            }) {
                Text("Publish Feedback")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blueish.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Text("Your review will be posted on list of review")
                .font(.footnote)
                .foregroundColor(.gray)

            Spacer()
            Spacer()
        }
        .padding()
    }
}


#Preview {
    FeedbackView()
}
