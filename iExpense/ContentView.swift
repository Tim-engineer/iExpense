//
//  ContentView.swift
//  iExpense
//
//  Created by Tim Matlak on 04/06/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Hashable {
    var id = UUID()
    
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses: Hashable {
    static func == (lhs: Expenses, rhs: Expenses) -> Bool {
        return lhs.items == rhs.items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(items)
    }
    
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
    
    @State private var itemTypes = ["Personal", "Business"]
    @State private var itemType = "Personal"
    
    var body: some View {
        NavigationStack {
            
            Picker("Business/Personal", selection: $itemType) {
                ForEach(itemTypes, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.palette)
            .padding(.horizontal)
            List {
                ForEach(expenses.items) { item in
                    
                    if item.type == itemType {
                        if item.amount < 100 {
                            ListItem(name: item.name, type: item.type, amount: item.amount, color: .green, weight: .regular)
                        } else if item.amount < 500 {
                            ListItem(name: item.name, type: item.type, amount: item.amount, color: .purple, weight: .semibold)
                        } else {
                            ListItem(name: item.name, type: item.type, amount: item.amount, color: .red, weight: .bold)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Image(systemName: "plus")
                }
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

struct ListItem: View {
    
    let name: String
    let type: String
    let amount: Double
    let color: Color
    let weight: Font.Weight
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(type)
                    .font(.footnote)
            }
            
            Spacer()
            
            Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                .foregroundStyle(color)
                .fontWeight(weight)
        }
    }
}

