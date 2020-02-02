//
//  ContentView.swift
//  iExpense
//
//  Created by Dmitry Reshetnik on 02.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct Person: Codable {
    var name: String
    var surname: String
}

struct SecondView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var numbers = [Int]()
    @State private var currentNumber = UserDefaults.standard.integer(forKey: "Number")
    var name: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, \(name)!")
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                    UserDefaults.standard.set(self.currentNumber, forKey: "Number")
                }
                
                Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView: View {
    
    @ObservedObject var user = User()
    @State private var person = Person(name: "Taylor", surname: "Swift")
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            
            Button("Show Sheet") {
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(self.person) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
                
                self.showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: self.user.firstName)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
