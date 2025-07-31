//
//  UserDataLoader.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 31.07.2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserDataLoader: ObservableObject {
    
    @Published var fullName: String = ""
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.fullName = data["fullName"] as? String ?? "Unknown"
            }
        }
    }
}
