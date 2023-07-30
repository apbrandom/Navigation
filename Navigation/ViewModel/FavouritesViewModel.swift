//
//  FavouritesViewModel.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 28.07.2023.
//

import Foundation

class FavouritesViewModel {

    private var savedPosts: [CDPostItem]?

    init() {
        loadSavedPosts()
    }

    private func loadSavedPosts() {
        savedPosts = CoreDataStorageService.shared.fetchPostItems()
    }

    func numbersOfRow(in section: Int) -> Int {
        return savedPosts?.count ?? 0
    }

    func post(for index: Int) -> CDPostItem? {
        return savedPosts?[index]
    }
}

