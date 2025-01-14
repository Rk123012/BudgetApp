//
//  Transaction+CoreDataClass.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 14/1/25.
//

import Foundation
import CoreData

@objc(Transaction)
class Transaction: NSManagedObject {
    
    override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
    
}
