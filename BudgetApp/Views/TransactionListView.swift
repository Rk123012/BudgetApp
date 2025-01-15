//
//  TransactionListView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 15/1/25.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    
    @FetchRequest var transactions: FetchedResults<Transaction>
    @Environment(\.managedObjectContext) private var viewContext
    
    init(request : NSFetchRequest<Transaction>) {
        _transactions = FetchRequest(fetchRequest: request)
    }
    
    private func deleteTransaction(transaction : Transaction){
        do{
            viewContext.delete(transaction)
            try viewContext.save()
        }catch{
            print(error)
        }
        
    }
    
    var body: some View {
        if transactions.isEmpty {
            Text("No transactions found")
        }else {
            List{
                ForEach(transactions){ transaction in
                    HStack{
                        Text(transaction.title ?? "")
                        Spacer()
                        Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                    }
                }.onDelete { indexSet in
                    indexSet.forEach { index in
                        self.deleteTransaction(transaction: transactions[index])
                    }
                }
            }
        }
    }
}
