//
//  BookingConfirmationView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 13.05.2025.
//

import SwiftUI

struct BookingConfirmationView: View {
    var body: some View {
        ZStack {
            Color("lightBlue")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image("confirmTick")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("Thanks for your booking!")
                    .font(.title2)
                    .shadow(radius: 9.0)
                
                Text("You’ll receive a confirmation message soon.")
                    .foregroundColor(.black)
                
//                NavigationLink(destination: AboutDoctorView()) {
//                    Text("Go back to doctor's page")
//                        .foregroundColor(Color("blueish"))
//                        .padding()
//                }
                
                .foregroundColor(.blueish)
                .padding()
                
            }
            .padding()

        }
    }
}

#Preview {
    BookingConfirmationView()
}
