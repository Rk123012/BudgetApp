//
//  BudgetListView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 14/1/25.
//

import SwiftUI

struct BudgetListView: View {
    
    let budgetCategoryResuls : FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory : (BudgetCategory) -> Void
    var body: some View {
        List{
            if budgetCategoryResuls.isEmpty{
                Text("No Budget Category Found")
            }else{
                ForEach(budgetCategoryResuls){ budgetCategory in
                    NavigationLink( value: budgetCategory){
                        HStack{
                            Text(budgetCategory.title ?? "" )
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 10){
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                Text("\(budgetCategory.overSpent ? "overSpent" : "Remaining") \(Text(budgetCategory.remainingBudgeTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundColor(budgetCategory.overSpent ? .red : .green)
                            }
                        }
                        
                    }
                    
                }.onDelete { indexSet in
                    indexSet.map{budgetCategoryResuls[$0]}.forEach { it in
                        onDeleteBudgetCategory(it)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: BudgetCategory.self) { budgerCategory in
            BudgetDetailView(budgetCategory: budgerCategory)
        }
    }
}

