//
//  MainPageView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 15.06.2025.
//

import SwiftUI

struct DoctorCard: View {
    let doctor: Doctor
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            // Doctor image and info
            HStack(alignment: .top, spacing: 16) {
                
                
                
                Image(doctor.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(doctor.fullName)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.blueish)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(doctor.specialty)
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                    
                    if let reviews = doctor.reviews, !reviews.isEmpty {
                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .font(.body)
                            
                            Text("\(reviews.count) review\(reviews.count == 1 ? "" : "s")")
                                .font(.body)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
            }
            
            // Action buttons
            HStack(spacing: 15) {
                
                Spacer()
                
                Button("Book") {
                    
                }
                .font(.body)
                .bold()
                .foregroundStyle(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blueish)
                )
                
                Button("Call") {
                    // Call action
                }
                .font(.body)
                .bold()
                .foregroundStyle(.blueish)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blueish, lineWidth: 2)
                )
            }
        }
        .padding(28)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.lightBlue)
        )
        .frame(width: 360)
    }
}

struct MainPageView: View {
    @StateObject private var doctorViewModel = DoctorViewModel()
    
    @StateObject private var userDataLoader = UserDataLoader()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    ScrollView() {
                        
                        HStack {
                            Image("Medeasy")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Text("MEDEASY")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.blueish)
                            
                        }
                        
                        
                        HStack {
                            Text("Hi, \(userDataLoader.fullName)")
                                .padding(.leading, 20)
                                .padding(.bottom, 20)
                                .padding(.top, 10)
                                .font(.title3)
                                .bold()
                                .foregroundStyle(.blueish)
                            
                            Spacer()
                            
                        }
                        
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 35)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                                .foregroundStyle(.lightBlue)
                            
                            HStack {
                                Spacer()
                                
                                Text("Your health, one tap away")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.blueish)
                                    .padding(.leading, 20)
                                
                                
                                Image("doct")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                            }
                            
                        }
                        
                        
                        //MARK: - Services
                        
                        VStack {
                            
                            
                            HStack {
                                
                                Text("Services")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.blueish)
                                    .padding(.top, 30)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                
                            }
                            
                            
                            
                            
                            HStack {
                                
                                Button("Schedule Visit") {
                                    
                                }
                                .buttonStyle(ServiceButtonStyle())
                                
                                
                                
                                Button("Call Ambulance") {
                                    
                                }.buttonStyle(ServiceButtonStyle(
                                    cornerRadius: 35,
                                    padding: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20),
                                    textColor: .red,
                                    backgroundColor: .white,
                                    borderColor: .red, lineWidth: 3
                                ))
                                
                                
                            }
                            
                            HStack {
                                
                                Button("Nearby Hospitals") {
                                    print("")
                                }.buttonStyle(ServiceButtonStyle(
                                    cornerRadius: 35,
                                    padding: EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0),
                                    textColor: .blueish,
                                    backgroundColor: .lightBlue
                                ))
                                
                                
                                Button("Upcoming Visits") {
                                    
                                }.buttonStyle(ServiceButtonStyle(
                                    padding: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)))
                                
                            }
                            
                            
                            
                        }
                        
                        
                        VStack {
                            HStack {
                                
                                Text("Popular doctors")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.blueish)
                                    .padding(.top, 20)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                
                                NavigationLink(destination: HomeView()) {
                                    Text("Show All")
                                        .foregroundStyle(.gray)
                                }
                                .padding(.trailing, 20)
                                .padding(.top, 22)
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(doctorViewModel.doctors.prefix(6)) { doctor in
                                        NavigationLink(destination: AboutDoctorView(doctor: doctor)) {
                                            DoctorCard(doctor: doctor)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 10)
                            }
                            
                        }
                        
                        
                        
                    }
                }
                .onAppear {
                    userDataLoader.loadUserData()
                }
                
                NavigationLink(destination: ChatView()) {
                    Image("chatbot")
                        .resizable()
                        .frame(width: 55, height: 50)
                        .padding()
                        .background(Color.blueish)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 30)
            }
                
            }
        }
    }


#Preview {
    MainPageView()
}
