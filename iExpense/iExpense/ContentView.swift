//
//  ContentView.swift
//  iExpense
//
//  Created by user169251 on 4/20/20.
//  Copyright © 2020 JohanForsell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)").foregroundColor(self.amountColor(forAmount: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) { Image(systemName: "plus")})
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
            expenses.items.remove(atOffsets: offsets)
    }
    func amountColor(forAmount amount: Int) -> Color {
        switch amount {
        case Int.min..<10:
            return .green
        case 10..<100:
            return .orange
        default:
            return .red
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
