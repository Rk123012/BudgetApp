//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 14/1/25.
//

import SwiftUI

struct BudgetDetailView: View {
    
    let budgetCategory : BudgetCategory
    
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
            Spacer()
        }
    }
}

#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
}
