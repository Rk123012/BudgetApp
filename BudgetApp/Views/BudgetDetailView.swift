//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 14/1/25.
//

import SwiftUI
import CoreData

struct BudgetDetailView: View {
    
    let budgetCategory : BudgetCategory
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name : String = ""
    @State private var total : String = ""
    
    
    var isFormatValid : Bool {
        guard let totalAmount = Double(total) else {
            return false
        }
        return totalAmount > 0 && name.isEmpty == false
    }
    
    private func saveTheTransaction(){
        do{
            let transaction = Transaction(context: viewContext)
            transaction.title = name
            transaction.total = Double(total) ?? 0
            budgetCategory.addToTransactions(transaction)
            try viewContext.save()
        }catch{
            print(error)
        }
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                VStack(alignment: .leading){
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    HStack{
                        Text("Budget:")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                    }.fontWeight(.bold)
                }.padding(.leading, 20)
                Spacer()
            }
            
            Form{
                Section {
                    TextField("Name", text: $name)
                    TextField("Total", text: $total)
                }header: {
                    Text("Add Transaction")
                }
                HStack {
                    Spacer()
                    Button("Save Transaction"){
                        self.saveTheTransaction()
                    }.disabled(!isFormatValid)
                    Spacer()
                }
            }
            TransactionListView(request: BudgetCategory.transactionsByBudgetCategoryRequest(budgetCategory))
            
            Spacer()
        }
    }
}

#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
}
