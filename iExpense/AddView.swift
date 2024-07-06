//
//  AddView.swift
//  iExpense
//
//  Created by Tim Matlak on 05/06/2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var expense = Expense()
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $expense.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                
                TextField("Amount", value: $expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($expense.name)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        modelContext.insert(expense)
                        dismiss()
                    }
                    .tint(.green)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//#Preview {
//    AddView(expense: Expense(name: .constant(""), type: <#T##String#>, amount: <#T##Double#>))
//}
