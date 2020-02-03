//
//  Expenses.swift
//  iExpense
//
//  Created by Dmitry Reshetnik on 03.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import Foundation

class Expences: ObservableObject {
    @Published var items = [ExpanceItem]()
}
