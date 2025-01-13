//
//  BudgetCategory+CoreDataClass.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 13/1/25.
//

import Foundation
import CoreData

@objc(BudgetCategory)
class BudgetCategory: NSManagedObject {
    
    override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
    
}
