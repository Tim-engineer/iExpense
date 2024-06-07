//
//  ContentView.swift
//  iExpense
//
//  Created by Tim Matlak on 04/06/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
//    @State private var expenseItem = expe
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    
                    if item.type == "Personal" {
                        Section("Personal") {
                            if item.amount < 100 {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.name)")
                                            .font(.headline)
                                        Text("\(item.type)")
                                            .font(.footnote)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                        .foregroundStyle(.green)
                                    
                                }
                            } else if item.amount < 500 {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.name)")
                                            .font(.headline)
                                        Text("\(item.type)")
                                            .font(.footnote)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                        .foregroundStyle(.purple)
                                        .fontWeight(.semibold)
                                }
                            } else {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.name)")
                                            .font(.headline)
                                        Text("\(item.type)")
                                            .font(.footnote)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                        .foregroundStyle(.red)
                                        .fontWeight(.bold)
                                    
                                }
                            }
                        }
                    } else {
                        Section("Bussiness") {
                            if item.amount < 100 {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.name)")
                                            .font(.headline)
                                        Text("\(item.type)")
                                            .font(.footnote)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                        .foregroundStyle(.green)
                                    
                                }
                            } else if item.amount < 500 {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.name)")
                                            .font(.headline)
                                        Text("\(item.type)")
                                            .font(.footnote)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                        .foregroundStyle(.purple)
                                        .fontWeight(.semibold)
                                }
                            } else {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(item.name)")
                                            .font(.headline)
                                        Text("\(item.type)")
                                            .font(.footnote)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                        .foregroundStyle(.red)
                                        .fontWeight(.bold)
                                    
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
