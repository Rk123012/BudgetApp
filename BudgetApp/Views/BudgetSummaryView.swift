//
//  BudgetSummaryView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 15/1/25.
//

import SwiftUI

struct BudgetSummaryView: View {
    
    @ObservedObject var budgetCategory : BudgetCategory
    
    var body: some View {
        VStack{
            Text("\(budgetCategory.overSpent ? "overSpent" : "Remaining") \(Text(budgetCategory.remainingBudgeTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundColor(budgetCategory.overSpent ? .red : .green)
            
        }
    }
}

