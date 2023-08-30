//
//  FavouritesViewModel.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 28.07.2023.
//

import Foundation
import CoreData

class FavouritesViewModel {
    
    private var savedPosts: [CDPostItem]?
    
    init() {
        loadSavedPosts()
    }
    
    private func loadSavedPosts() {
        savedPosts = CoreDataStorageService.shared.fetchPostItems()
    }
    
    private func numbersOfRow(in section: Int) -> Int {
        return savedPosts?.count ?? 0
    }
    
    private func post(for index: Int) -> CDPostItem? {
        return savedPosts?[index]
    }
    
    func deletePost(_ post: CDPostItem, in context: NSManagedObjectContext) {
        CoreDataStorageService.shared.deletePostItem(postItem: post, in: context)
    }
    
} 

