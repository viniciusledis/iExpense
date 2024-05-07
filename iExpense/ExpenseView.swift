//
//  ExpenseView.swift
//  iExpense
//
//  Created by Vinicius Ledis on 11/04/2024.
//

import SwiftData
import SwiftUI

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        
                        Text(expense.type)
                    }
                    
                    Spacer()
                    
                    Text(expense.amount, format: .currency(code: "BRL"))
                }
                .accessibilityElement()
                .accessibilityLabel("\(expense.name), \(expense.amount, format: .currency(code: "BRL"))")
                .accessibilityHint(expense.type)
            }
            .onDelete(perform: deleteExpenses)
        }
    }
    init(expenseFilter: String?) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            if let filter = expenseFilter {
                if filter == "Personal" {
                    return expense.type == "Personal"
                } else if filter == "Business" {
                    return expense.type == "Business"
                } else {
                    return true
                }
            } else {
                return true
            }
        }, sort: [SortDescriptor(\Expense.name),
                  SortDescriptor(\Expense.amount)])
    }

    func deleteExpenses(_ indexSet: IndexSet) {
        for index in indexSet {
            let expense = expenses[index]
            modelContext.delete(expense)
        }
    }

}

#Preview {
    ExpenseView(expenseFilter: "All")
        .modelContainer(for: Expense.self)
}
