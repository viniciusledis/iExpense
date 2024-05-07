//
//  AddView.swift
//  iExpense
//
//  Created by Vinicius Ledis on 24/02/2024.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var expense: Expense
   
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $expense.name)
                
                Picker("Type", selection: $expense.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $expense.amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let item = Expense(name: expense.name, type: expense.type, amount: expense.amount)
                        modelContext.insert(item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
            .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expense.self, configurations: config)
        let item = Expense(name: "Pizza", type: "Personal", amount: 20)
        return AddView(expense: item)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
   // AddView(expense: .init(name: "Pizza", type: "Personal", amount: 20.0))
}
