//
//  PostsStorage.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 06.08.2023.
//

import Foundation

class PostStorage {
    
    static let shared = PostStorage()
    
    private(set) var posts: [Post] = Post.make()
    
    private init() { }
    
    func insertPost(_ post: Post, at index: Int) {
        posts.insert(post, at: index)
    }
    
    func getAllPosts() -> [Post] {
        return posts
    }

}
