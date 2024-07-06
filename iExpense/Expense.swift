//
//  Expense.swift
//  iExpense
//
//  Created by Tim Matlak on 06/07/2024.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String = "", type: String = "", amount: Double = 0) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
