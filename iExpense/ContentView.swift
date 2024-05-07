//
//  ContentView.swift
//  iExpense
//
//  Created by Vinicius Ledis on 16/02/2024.
//

import SwiftData
import SwiftUI

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double
    let date = Date.now
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var filter: String = "All"
    let filters = ["All", "Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            ExpenseView(expenseFilter: filter)
            .navigationTitle("iExpense")
            .toolbar {
                    NavigationLink {
                        AddView(expense: .init(name: "", type: "Personal", amount: 0))
                    } label: {
                        Image(systemName: "plus")
                    }
                Menu("Filter", systemImage: "arrow.up.arrow.down") {
                    Picker("Filter", selection: $filter) {
                        ForEach(filters, id: \.self) { filter in
                            Text(filter).tag(filter)
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
