//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Tim Matlak on 04/06/2024.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
