//
//  QuoteCD+CoreDataProperties.swift
//  QuoteGarden
//
//  Created by Kamila Lech on 28/10/2022.
//
//

import Foundation
import CoreData
import SwiftUI

extension QuoteCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteCD> {
        return NSFetchRequest<QuoteCD>(entityName: "QuoteCD")
    }

    @NSManaged public var text: String?
    @NSManaged public var author: String?
    @NSManaged public var genere: String?
    
    static func basicFetchRequest() -> FetchRequest<QuoteCD> {
        return FetchRequest<QuoteCD>(entity: QuoteCD.entity(), sortDescriptors: [])
      }
    
    
    static func saveQuote(text:String, author:String, genere:String, using managedObjectContext: NSManagedObjectContext) {
        
        let quoteCD = QuoteCD(context: managedObjectContext)
        quoteCD.text = text
        quoteCD.author = author
        quoteCD.genere = genere
        
        do {
            try managedObjectContext.save()
            print("Quote Saved!!")
        } catch {
            print(error.localizedDescription)
        }
    }

}

extension QuoteCD: Identifiable {
 
}
