//
//  SignUpView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 13.05.2025.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var mobileNumber: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            HStack {
                Image("Medeasy")
                    .offset(y: -370)
                
                Text("MEDEASY")
                    .font(.custom("", size: 20))
                    .bold()
                    .offset(y: -370)
            }
            
            
            HStack {
                Circle()
                    .frame(width: 208)
                    .foregroundStyle(.blue)
                    .offset(x: 4, y: -327)
                
                
                Circle()
                    .frame(width: 208)
                    .foregroundStyle(.blue)
                    .opacity(0.4)
                    .offset(x: 204, y: -327)
                
                Circle()
                    .frame(width: 208)
                    .foregroundStyle(.blue)
                
                    .offset(x: 24, y: -327)
                
            }
            
            RoundedRectangle(cornerRadius: 40)
                .frame(width: UIScreen.main.bounds.width, height: 800)
                .offset(y: 200)
                .foregroundStyle(.placeholder)
            
            VStack {
                
                Text("Register")
                    .font(.custom("", size: 24))
                    .bold()
                    .padding(.top, 200)
                    .padding(.bottom, 40)
                
                    
                
                
                TextField("Full Name", text: $fullName)
                    .padding(.horizontal)
                    .padding([.leading, .trailing], 172)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 294, height: 66)
                            .shadow(radius: 5.0)
                        )
                    .padding(.bottom, 50)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                    .padding([.leading, .trailing], 172)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 294, height: 66)
                            .shadow(radius: 5.0)
                        )
                    .padding(.bottom, 50)
                
                TextField("Mobile Number", text: $mobileNumber)
                    .padding(.horizontal)
                    .padding([.leading, .trailing], 172)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 294, height: 66)
                            .shadow(radius: 5.0)
                        )
                    .padding(.bottom, 50)
                
                TextField("Password", text: $password)
                    .padding(.horizontal)
                    .padding([.leading, .trailing], 172)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 294, height: 66)
                            .shadow(radius: 5.0)
                        )
                    .padding(.bottom, 60)
                
                
                Button(action: {
                    AuthManager.shared.register(fullName: fullName, phoneNumber: mobileNumber, email: email, password: password) { result in
                        switch result {
                        case .success:
                            print("User registered successfully")
                            changeRootView(to: MainTabBarController())
                            
                        case .failure(let error):
                            print("Signup error: \(error.localizedDescription)")
                        }
                    }
                }) {
                    Text("Sign up")
                        .foregroundColor(.white)
                        .font(.custom("", size: 18))
                        .bold()
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue)
                                .frame(width: 294, height: 66)
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                
                Text("Already have an account?")
                    .padding(.horizontal)
                
                Button(action: {
                    changeView(to: LoginView())
                }) {
                    Text("Sign in")
                }
                    
                
            }
            
            

            
            
        }.hideKeyboardOnTap()
    }
    
    func changeRootView(to viewController: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = viewController
            sceneDelegate.window?.makeKeyAndVisible()
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
    SignUpView()
}
