//
//  ProfileView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 09.05.2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    @State private var isDarkMode = false
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""


    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
//                Color.blue.opacity(0.2)
//                    .frame(height: 200)
//                    .edgesIgnoringSafeArea(.top)

                Circle()
                    .stroke(Color.blue, lineWidth: 1)
                    .frame(width: 120, height: 120)
                    .background(Circle().fill(Color.white))
                    .offset(y: 60)
            }

            Spacer()
                .frame(height: 70)

            Text(fullName)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 20)

            // Contact info
            VStack(spacing: 15) {
                HStack {
                    Text("Phone")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(phoneNumber)
                }

                HStack {
                    Text("Email")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(email)
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 30)

            Divider()

            VStack(alignment: .leading, spacing: 25) {
                Toggle(isOn: $isDarkMode) {
                    Label("Dark mode", systemImage: "moon")
                }

                Button {
                    
                } label: {
                    Label("My bookings", systemImage: "calendar")
                }

                Button {
                    
                    logout()
                    
                } label: {
                    Label("Log out", systemImage: "arrow.right.square")
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)

            Spacer()

//
//            .padding()
//            .background(Color.white.shadow(radius: 2))
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
                    email = data["email"] as? String ?? "-"
                    phoneNumber = data["phoneNumber"] as? String ?? "-"
                }
            }
        }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("User logged out")
            changeView(to: SignUpView())
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func changeView<Content: View>(to view: Content) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            let hostingController = UIHostingController(rootView: view)
            sceneDelegate.window?.rootViewController = hostingController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    
}

#Preview {
    ProfileView()
}
