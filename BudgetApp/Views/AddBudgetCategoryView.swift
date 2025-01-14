//
//  AddCategoryView.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 13/1/25.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var title : String = ""
    @State private var total : Double = 0
    @State private var messages : [String] = []
    
    
    var isValid : Bool{
        messages = []
        if title.isEmpty{
            messages.append( "Title is required")
        }
        if total <= 0{
            messages.append("Total must be greater than zero")
        }
        if messages.isEmpty{
            return true
        }else{
            return false
        }
    }
    
    private func save(){
        let budgetCategory = BudgetCategory(context: viewContext)
        budgetCategory.title = title
        budgetCategory.total = total
        do{
            try viewContext.save()
            dismiss()
        }catch let error{
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Slider(value: $total, in: 0...500, step: 50){
                    Text("Total \(total)")
                }minimumValueLabel: {
                    Text("$0")
                }maximumValueLabel: {
                    Text("$500")  
                }
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(messages, id: \.self){ message in
                    Text(message)
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        if isValid{
                            save()
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    AddBudgetCategoryView()
}
