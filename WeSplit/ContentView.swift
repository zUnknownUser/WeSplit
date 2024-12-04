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

    var totalPerPerson: Double {
        let tipValue = checkAmount * Double(tipPercentage) / 100
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / Double(numberOfPeople)
        
        return amountPerPerson
    }
    var totalAmount: Double {
        let tipValue = checkAmount * Double(tipPercentage) / 100
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    //    Adicione outra seção mostrando o valor total da conta - ou seja, o valor original mais o valor da gorjeta, sem dividir pelo número de pessoas
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
                    
                    Section("Amount Per Person"){
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        
                    }
                    
                    Section("Total Amount"){
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
