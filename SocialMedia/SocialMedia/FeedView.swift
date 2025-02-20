//
//  FeedView.swift
//  SocialMedia
//
//  Created by Куаныш Спандияр on 19.02.2025.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var feedSystem = FeedSystem()

    var body: some View {
        NavigationView {
            List {
                ForEach(feedSystem.feedPosts, id: \.id) { post in
                    VStack(alignment: .leading) {
                        Text(post.content)
                            .font(.headline)
                        Text("\(post.likes) likes")
                            .font(.subheadline)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        feedSystem.removePost(feedSystem.feedPosts[index])
                    }
                }
            }
            .navigationTitle("Feed")
            .toolbar {
                Button("Add Post") {
                    let newPost = Post(id: UUID(), authorId: UUID(), content: "New Post! #SwiftUI", likes: 101)
                    feedSystem.addPost(newPost)
                }
            }
        }
    }
}


#Preview {
    FeedView()
}
