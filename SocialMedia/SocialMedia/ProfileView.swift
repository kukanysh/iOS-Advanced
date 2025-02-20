//
//  ProfileView.swift
//  SocialMedia
//
//  Created by Куаныш Спандияр on 19.02.2025.
//

import SwiftUI
import Collections


// MARK: - PostRowView (Ensure it's in the correct scope)
struct PostRowView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.content)
                .font(.body)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            HStack {
                Text("\(post.likes) likes")
                    .font(.caption)
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.3)))
        .padding(.horizontal)
        .padding(10)
    }
}



struct ProfileView: View {
    let user: UserProfile
    let posts: [Post]
    
    var userPosts: [Post] {
        posts.filter { $0.authorId == user.id }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                // MARK: - Profile Picture & Followers
                HStack(spacing: 10) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(user.username)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("\(user.followers)")
                                Text("followers")
                            }
                        }
                        Text(user.bio)
                    }
                    
                    Spacer()
                }
                .frame(width: 360)
                .padding(30)
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                        .frame(width: 380, height: 150)
                        .foregroundStyle(.gray)
                        .opacity(0.2)
                )
                
                Text("Posts")
                    .font(.headline)
                    .frame(width: 100)
                    .offset(x: -150, y: 20)
                    .padding(.leading, -20)
                
                // MARK: - Display User's Posts
                VStack(spacing: 10) {
                    ForEach(userPosts, id: \.id) { post in
                        PostRowView(post: post)
                    }
                }
            }
            .padding(70)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    let sampleUser = UserProfile(
        id: UUID(),
        username: "Kuanysh",
        bio: "iOS Developer",
        followers: 123
    )

    let samplePosts = [
        Post(id: UUID(), authorId: sampleUser.id, content: "First post!", likes: 10),
        Post(id: UUID(), authorId: sampleUser.id, content: "Another update!", likes: 20),
        Post(id: UUID(), authorId: UUID(), content: "Not by this user", likes: 5)
    ]

    return ProfileView(user: sampleUser, posts: samplePosts)
}
