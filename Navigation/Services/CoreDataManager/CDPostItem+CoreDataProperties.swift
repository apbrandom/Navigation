//
//  CDPostItem+CoreDataProperties.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 27.07.2023.
//
//

import Foundation
import CoreData


extension CDPostItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPostItem> {
        return NSFetchRequest<CDPostItem>(entityName: "CDPostItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var image: String?
    @NSManaged public var likes: Int32
    @NSManaged public var views: Int32

}

extension CDPostItem : Identifiable {

}