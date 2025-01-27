//
//  NumberFormater+Extensions.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 13/1/25.
//

import Foundation
extension NumberFormatter{
    
    static var currency : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.currencySymbol = Locale(identifier: "en_US").currencySymbol
        return formatter
    }
}
