//
//  FavouritesViewModel.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 28.07.2023.
//

import Foundation
//import CoreData

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
    
    func deletePost(_ post: CDPostItem) {
        let viewContext = CoreDataStorageService.shared.viewContext
        viewContext.delete(post)
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Ошибка при удалении поста: \(error.localizedDescription)")
        }
    }
    
}

