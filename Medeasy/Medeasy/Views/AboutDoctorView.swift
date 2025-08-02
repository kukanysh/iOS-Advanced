//
//  AboutDoctorView.swift
//  Medeasy
//
//  Created by Zhaina Igenbek on 13.05.2025.
//

import SwiftUI

struct AboutDoctorView: View {
    let doctor: Doctor

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(doctor.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 350)
                    .clipped()
                    .padding(.top, -16)
                
                Text(doctor.fullName)
                    .font(.title2)
                    .bold()
                
                Text(doctor.specialty)
                    .font(.title3)
                    .foregroundColor(Color("blueish"))
                
                Rectangle()
                    .fill(Color("blueish"))
                    .frame(height: 1)
                
                NavigationLink(destination: SlotsView()) {
                    HStack {
                        Text("Book an appointment")
                            .foregroundColor(.black)
                        Spacer()
                        Image("nav")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                    .padding(.horizontal)
                }
                
                Rectangle()
                    .fill(Color("blueish"))
                    .frame(height: 1)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("About Doctor")
                        .foregroundColor(.black.opacity(0.7))
                    
                    Rectangle()
                        .fill(Color("blueish"))
                        .frame(height: 0.5)
                    
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry...")
                }
                .padding(.horizontal)
                
                Text("Reviews")
                    .font(.headline)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(doctor.reviews ?? [], id: \.author) { review in
                        HStack(alignment: .top, spacing: 12) {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 40, height: 40)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(review.author)
                                    .font(.subheadline).bold()
                                Text(review.text)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                        }
                    }

                }
                .padding(.horizontal)
                                    
                NavigationLink(destination: FeedbackView()) {
                    Text("Give feedback")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                
            }
            .padding(.top)
        }
        .ignoresSafeArea()
        .safeAreaPadding(.horizontal, -50)
        .background(Color("lightBlue"))
        .toolbarBackground(.hidden, for: .navigationBar)
        
    }
}

#Preview {
    AboutDoctorView(doctor: Doctor(
        id: 1,
        fullName: "Dr. Mynzhylky Berdikhozhaev",
        shortName: "Dr. Jane",
        specialty: "Neurosurgeon",
        imageName: "doctor1", // Make sure this image exists in your assets
        about: "An experienced cardiologist with 15 years of service.",
        reviews: [
            Review(author: "Alice", text: "Very professional and kind."),
            Review(author: "Bob", text: "Helped me recover quickly.")
        ]
    ))
}

