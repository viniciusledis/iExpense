//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Vinicius Ledis on 16/02/2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
