//
//  ContentView.swift
//  SocialMedia
//
//  Created by Куаныш Спандияр on 19.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let sampleUser = UserProfile(
            id: UUID(),
            username: "Kuanysh",
            bio: "iOS Developer",
            followers: 123
        )

        let samplePosts = [
            Post(id: UUID(), authorId: UUID(), content: "This is another user's post", likes: 5),
            Post(id: UUID(), authorId: UUID(), content: "This is not Kuanysh's post", likes: 2),
            Post(id: UUID(), authorId: UUID(), content: "Another user's content", likes: 7),
            Post(id: UUID(), authorId: sampleUser.id, content: "Hello from Kuanysh!", likes: 10),
            Post(id: UUID(), authorId: sampleUser.id, content: "My second post!", likes: 15)
        ]

        return TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "magnifyingglass")
                }

            ProfileView(user: sampleUser, posts: samplePosts) // ✅ Pass posts here
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
