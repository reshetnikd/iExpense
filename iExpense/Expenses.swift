//
//  Expenses.swift
//  iExpense
//
//  Created by Dmitry Reshetnik on 03.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items: [ExpanceItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoder = try? decoder.decode([ExpanceItem].self, from: items) {
                self.items = decoder
                return
            }
        }
        self.items = []
    }
}
