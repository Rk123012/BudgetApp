//
//  ContentView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 13/1/25.
//

import SwiftUI


enum SheetAction: Identifiable {
    
    case add
    case edit(BudgetCategory)
    
    var id: Int {
        switch self {
            case .add:
                return 1
            case .edit(_):
                return 2
        }
    }
    
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var sheetAction: SheetAction?

    
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
    
    private func editBudgetCategory(_ category : BudgetCategory){
        sheetAction = .edit(category)
    }
    
    var body: some View {
        NavigationStack{
            
            VStack {
                
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .fontWeight(.bold)
                
                BudgetListView(budgetCategoryResuls: budgetCategoryResults, onDeleteBudgetCategory: { category in
                    self.delete(category: category)
                }, onEditBudgetCategory: editBudgetCategory)
            }
            .sheet(item: $sheetAction, content: { sheetAction in
                switch sheetAction {
                case .add:
                    AddOrUpdateBudgetCategoryView(previousBudgetCategory: nil)
                case .edit(let budgetCategory):
                    AddOrUpdateBudgetCategoryView(previousBudgetCategory: budgetCategory)
                }
            })
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category"){
                        sheetAction = .add
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
