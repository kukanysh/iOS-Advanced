//
//  FeedSystem.swift
//  SocialMedia
//
//  Created by Куаныш Спандияр on 20.02.2025.
//

import Foundation
import Collections

class FeedSystem: ObservableObject {
    // TODO: Implement cache storage
    // Consider: Which collection type is best for fast lookup?
    // Requirements: O(1) access time, storing UserProfile objects with UserID keys
    @Published var userCache: [UUID: UserProfile] = [:]
    
    // TODO: Implement feed storage
    // Consider: Which collection type is best for ordered data?
    // Requirements: Maintain post order, frequent insertions at the beginning
    @Published var feedPosts: Deque<Post> = []
    
    // TODO: Implement hashtag storage
    // Consider: Which collection type is best for unique values?
    // Requirements: Fast lookup, no duplicates
    @Published var hashtags: Set<String> = []
    
    func addPost(_ post: Post) {
        feedPosts.prepend(post)  // Efficient O(1) insertion at the beginning
        
        // Extract hashtags from post content
        let words = post.content.split(separator: " ")
        for word in words where word.hasPrefix("#") {
            hashtags.insert(String(word)) // Ensures uniqueness
        }
    }

    func removePost(_ post: Post) {
        if let index = feedPosts.firstIndex(of: post) {
            feedPosts.remove(at: index) // O(n) in worst case
        }
        
        // Optional: Clean up hashtags if no posts contain them
    }
}
