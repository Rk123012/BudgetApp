//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 13/1/25.
//

import SwiftUI

@main
struct BudgetAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
