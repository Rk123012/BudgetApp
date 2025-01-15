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
    
    var overSpent : Bool {
        return remainingBudgeTotal < 0
    }
    
    var transactionsTotal : Double {
        return self.transactionsArray.reduce(0) { $0 + $1.total }
    }
    
    var remainingBudgeTotal : Double{
        return self.total - self.transactionsTotal
    }
    
    private var transactionsArray : [Transaction] {
        guard let transactions = self.transactions else { return []}
        let allTransactions : [Transaction] =  (transactions.allObjects as? [Transaction]) ?? []
        return allTransactions.sorted { $0.dateCreated! > $1.dateCreated! }
    }
    
    static func transactionsByBudgetCategoryRequest(_ budgetCategory : BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Transaction.dateCreated), ascending: false)]
        request.predicate = NSPredicate(format: "category == %@", budgetCategory)
        return request
    }
}
