//
//  BudgetListView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 14/1/25.
//

import SwiftUI

struct BudgetListView: View {
    
    let budgetCategoryResuls : FetchedResults<BudgetCategory>
    
    var body: some View {
        List{
            if budgetCategoryResuls.isEmpty{
                Text("No Budget Category Found")
            }else{
                ForEach(budgetCategoryResuls){ budgetCategory in
                    HStack{
                        Text(budgetCategory.title ?? "" )
                        Spacer()
                        
                        VStack{
                            Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                        }
                    }
                    
                }
            }
        }
    }
}

