//
//  CoreDataStorageService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 27.07.2023.
//

import CoreData
import UIKit

class CoreDataStorageService {
    
    // Singleton
    static let shared = CoreDataStorageService()
    
    // Reference to managed object context
    let context: NSManagedObjectContext
    
    private init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func savePostItem(title: String, author: String, image: UIImage?, likes: Int32, views: Int32) {
        let postItem = CDPostItem(context: context)
        postItem.title = title
        postItem.author = author
        postItem.image = image
        postItem.likes = likes
        postItem.views = views
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchPostItems() -> [CDPostItem]? {
        let request = NSFetchRequest<CDPostItem>(entityName: "CDPostItem")
        do {
            let result = try context.fetch(request)
            return result
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
//    func deletePostItem(_ postItem: CDPostItem) {
//        context.delete(postItem)
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
//    
//    func updatePostItem(_ postItem: CDPostItem, newTitle: String, newAuthor: String, newImage: String, newLikes: Int32, newViews: Int32) {
//        postItem.title = newTitle
//        postItem.author = newAuthor
//        postItem.image = newImage
//        postItem.likes = newLikes
//        postItem.views = newViews
//        
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
    
}


