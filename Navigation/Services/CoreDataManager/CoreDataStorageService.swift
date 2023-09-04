//
//  CoreDataStorageService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 27.07.2023.
//

import CoreData
import UIKit

class CoreDataStorageService {
    
    static let shared = CoreDataStorageService()
    
    // Reference to managed object context
    
    let viewContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext

    private init() {
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        viewContext = container.viewContext
        backgroundContext = container.newBackgroundContext()

        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(notification:)), name: .NSManagedObjectContextDidSave, object: backgroundContext)
    }
    
    func savePostItem(title: String, author: String, image: UIImage?, likes: Int32, views: Int32) {
            backgroundContext.perform {
                let postItem = CDPostItem(context: self.backgroundContext)
                
                postItem.title = title
                postItem.author = author
                
                if let img = image {
                    postItem.image = img.jpegData(compressionQuality: 1.0)
                }
                
                postItem.likes = likes
                postItem.views = views
            
                do {
                    try self.backgroundContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    
    func fetchPostItems() -> [CDPostItem]? {
            // Using the viewContext to fetch is okay since it won't block the UI
            let request = NSFetchRequest<CDPostItem>(entityName: "CDPostItem")
            do {
                let result = try viewContext.fetch(request)
                return result
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return nil
            }
        }
    
    func deletePostItem(postItem: CDPostItem) {
        backgroundContext.perform {
            self.backgroundContext.delete(postItem)
            do {
                try self.backgroundContext.save()
            } catch let error as NSError {
                print("Could not save after delete. \(error), \(error.userInfo)")
            }
        }
    }

    @objc private func contextDidSave(notification: Notification) {
        viewContext.perform {
            self.viewContext.mergeChanges(fromContextDidSave: notification)
        }
    }
}


