//
//  HomeView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 09.05.2025.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct HomeView: View {
    @StateObject private var viewModel = DoctorViewModel()
    @State private var searchText = ""
    @State private var fullName: String = ""
    
    var filteredDoctors: [Doctor] {
        if searchText.isEmpty {
            return viewModel.doctors
        } else {
            return viewModel.doctors.filter {
                $0.fullName.localizedCaseInsensitiveContains(searchText) ||
                $0.specialty.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    
                    Text("Hi, \(fullName)")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                }
                .padding()

                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.2))
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search", text: $searchText)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.horizontal)
                    )
                    .frame(height: 50)
                    .padding(.horizontal)

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredDoctors) { doctor in
                            NavigationLink(destination: AboutDoctorView(doctor: doctor)) {
                                HStack {
                                    Image(doctor.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    VStack(alignment: .leading) {
                                        Text(doctor.shortName)
                                            .bold()
                                            .foregroundColor(.black)
                                        Text(doctor.specialty)
                                            .foregroundColor(Color("blueish"))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color.white)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            loadUserData()
        }
    }
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                fullName = data["fullName"] as? String ?? "Unknown"
            }
        }
    }
    
    
}


#Preview {
    HomeView()
}
