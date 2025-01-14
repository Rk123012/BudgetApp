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
                            
                            VStack{
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                            }
                        }
                        
                    }
                    
                }.onDelete { indexSet in
                    indexSet.map{budgetCategoryResuls[$0]}.forEach { it in
                        onDeleteBudgetCategory(it)
                    }
                }
            }
        }.navigationDestination(for: BudgetCategory.self) { budgerCategory in
            BudgetDetailView(budgetCategory: budgerCategory)
        }
    }
}

