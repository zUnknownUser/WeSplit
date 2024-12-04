//
//  ContentView.swift
//  WeSplit
//
//  Created by Lucas Amorim on 04/12/24.
//


import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipsPercentages = [10,15,20,25,30,0]

    var totalPerSeron: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal + peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Section{
                Form{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(0..<20){numberOfPeople in
                            Text("\(numberOfPeople) People")
                        }
                    }
                    Section("How much do you want to tip?"){
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipsPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Section{
                        Text(totalPerSeron, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        
                    }
                    
                }
                .foregroundColor(.accentColor)
                
                
            }
            .navigationTitle("We Split")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
