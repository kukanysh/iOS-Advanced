//
//  ProfileManager.swift
//  SocialMedia
//
//  Created by Куаныш Спандияр on 19.02.2025.
//

import Foundation


protocol ProfileUpdateDelegate: AnyObject {
    // TODO: Consider protocol inheritance requirements
    // Think: When should we restrict protocol to reference types only?
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager {
    // TODO: Think about appropriate storage type for active profiles
    private var activeProfiles: [String: UserProfile]
    
    // TODO: Consider reference type for delegate
    weak var delegate: ProfileUpdateDelegate?
    
    // TODO: Think about reference management in closure
    var onProfileUpdate: ((UserProfile) -> Void)?
    
    init(delegate: ProfileUpdateDelegate) {
        // TODO: Implement initialization
        self.delegate = delegate
        self.activeProfiles = [:]
    }
    
    func loadProfile(id: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        // Simulating an async profile fetch
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return } // Prevent strong reference
            
            // Simulate success response
            let profile = UserProfile(id: UUID(), username: "Kuanysh", bio: "iOS Developer", followers: 123)
            
            DispatchQueue.main.async {
                self.activeProfiles[id] = profile // Store in cache
                
                self.delegate?.profileDidUpdate(profile) // Notify delegate
                self.onProfileUpdate?(profile) // Call closure if set
                
                completion(.success(profile)) // Return result
            }
        }
    }
}

class UserProfileViewController {
    // TODO: Consider reference type for these properties
    var profileManager: ProfileManager?
    var imageLoader: ImageLoader?
    
    func setupProfileManager() {
        // TODO: Implement setup
        // Think: What reference type should be used in closure?
        
        profileManager = ProfileManager(delegate: self)
        
        // Preventing retain cycle using `[weak self]`
        profileManager?.onProfileUpdate = { [weak self] updatedProfile in
            self?.updateUI(with: updatedProfile)
        }
    }
    
    func updateProfile() {
        profileManager?.loadProfile(id: "123") { [weak self] result in
            guard let self = self else { return } // Prevents retain cycle
            
            switch result {
            case .success(let profile):
                self.updateUI(with: profile)
            case .failure(let error):
                print("Error loading profile: \(error)")
            }
        }
    }

    private func updateUI(with profile: UserProfile) {
        print("Profile updated: \(profile.username)")
    }
}

// Extending `UserProfileViewController` to conform to `ProfileUpdateDelegate`
extension UserProfileViewController: ProfileUpdateDelegate {
    func profileDidUpdate(_ profile: UserProfile) {
        updateUI(with: profile)
    }
    
    func profileLoadingError(_ error: Error) {
        print("Failed to load profile: \(error)")
    }
}
