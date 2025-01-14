//
//  ContentView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 13/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var isPresented : Bool = false
    
    var total : Double {
        budgetCategoryResults.reduce(0) { $0 + $1.total }
    }
    
    private func delete(category : BudgetCategory){
        viewContext.delete(category)
        do{
            try viewContext.save()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationStack{
            
            VStack {
                
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                
                BudgetListView(budgetCategoryResuls: budgetCategoryResults, onDeleteBudgetCategory: { category in
                    self.delete(category: category)
                })
            }
            .sheet(isPresented: $isPresented, content: {
                AddBudgetCategoryView()
            })
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category"){
                        isPresented = true
                    }
                }
            }
            
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
