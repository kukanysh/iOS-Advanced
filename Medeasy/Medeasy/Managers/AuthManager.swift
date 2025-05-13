//
//  AuthManager.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 11.05.2025.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AuthManager {
    static let shared = AuthManager()

    private init() {}

    func register(fullName: String, phoneNumber: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = fullName
                changeRequest.commitChanges { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        let db = Firestore.firestore()
                        db.collection("users").document(user.uid).setData([
                            "fullName": fullName,
                            "email": email,
                            "phoneNumber": phoneNumber
                        ]) { error in
                            if let error = error {
                                print("Error writing user to Firestore: \(error)")
                                completion(.failure(error))
                            } else {
                                print("User saved to Firestore")
                                self.login(email: email, password: password, completion: completion)
                            }
                        }
                    }
                }
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func logout() throws {
        try Auth.auth().signOut()
    }
}

