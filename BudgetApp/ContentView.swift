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
    
    var body: some View {
        NavigationStack{
            
            VStack {
                
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                
                BudgetListView(budgetCategoryResuls: budgetCategoryResults)
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
}
