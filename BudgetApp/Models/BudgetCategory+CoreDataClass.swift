//
//  BudgetCategory+CoreDataClass.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 14/1/25.
//

import Foundation
import CoreData

@objc(BudgetCategory)
class BudgetCategory: NSManagedObject {
    
    override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
    static func transactionsByBudgetCategoryRequest(_ budgetCategory : BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.dateCreated), ascending: false)]
        request.predicate = NSPredicate(format: "category == %@", budgetCategory)
        return request
    }
}
