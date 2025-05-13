//
//  MoreView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 09.05.2025.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 1) {
                Divider()
                    .background(Color.blue.opacity(0.5))
                    .frame(minHeight: 1)
                
                NavigationLink(destination: ProfileView()) {
                    ListItem(icon: "profile", label: "Profile")
                }
                
                
                NavigationLink(destination: ProfileView()) {
                    ListItem(icon: "calendar", label: "My Bookings")
                }
                
                NavigationLink(destination: HomeView()) {
                    ListItem(icon: "bi_people-fill", label: "Doctors")
                }
                
                NavigationLink(destination: ProfileView()) {
                    ListItem(icon: "call", label: "Call the hospital")
                }
                
                NavigationLink(destination: ProfileView()) {
                    ListItem(icon: "pharmacy", label: "Call the pharmacy")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

struct ListItem: View {
    let icon: String
    let label: String
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.leading, 20)
            Text(label)
                .foregroundColor(.primary)
                .padding(.leading, 10)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1, alignment: .init(horizontal: .leading, vertical: .bottom))
                .foregroundColor(Color.blue.opacity(0.5)),
            alignment: .bottom
        )
    }
}

#Preview {
    MoreView()
}
