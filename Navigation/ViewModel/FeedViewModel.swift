//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Вадим Виноградов on 16.05.2023.
//

import Foundation

class FeedViewModel {
    var feedModel = FeedModel()

    func checkWord(_ word: String) -> Bool {
        return feedModel.check(word: word)
    }
}
