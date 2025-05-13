//
//  LoginView.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 13.05.2025.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
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
                
                Text("Log In")
                    .font(.custom("", size: 24))
                    .bold()
                    .padding(.top, 230)
                    .padding(.bottom, 40)
                
                
                TextField(" Email", text: $email)
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
                
                TextField("Password", text: $password)
                    .padding(.horizontal)
                    .padding([.leading, .trailing], 172)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 294, height: 66)
                            .shadow(radius: 5.0)
                        )
                    .padding(.bottom, 80)
                
                
                Button(action: {
                    if isValidEmail(email) {
                            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                                if let error = error {
                                    print("Login error:", error.localizedDescription)
                                } else {
                                    print("Successfully logged in with email.")
                                    changeRootView(to: MainTabBarController())
                                }
                            }
                        } else {
                            print("Invalid email format or phone login not supported yet.")
                            // Optionally: show an alert or handle phone login
                        }
                }) {
                    Text("Sign in")
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
                
                Text("Forget password?")
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 170)
                    .padding(.bottom, 30)
                
                
                Button(action: {
                    // logic
                }) {
                    
                    HStack {
                        Text("Sign Up with Google")
                            .foregroundColor(.black)
                            .font(.custom("", size: 18))
                            .padding(.leading, -60)
                            .bold()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width: 294, height: 66)
                                    .shadow(radius: 5.0)
                            )
                        
                        
                        Image("google")
                            .resizable()
                            .frame(width: 70, height: 70)
                        
                    }
                        
                    
                }
                .padding(.horizontal)
                .padding(.leading, 80)
                .padding(.bottom, 30)
                
               
            }
            
            

            
            
        }
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    func changeRootView(to viewController: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = viewController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }

    
    
}

#Preview {
    LoginView()
}
