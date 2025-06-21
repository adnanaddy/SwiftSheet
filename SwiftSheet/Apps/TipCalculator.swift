//
//  TipCalculator.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 6/21/25.
//

import SwiftUI

public struct TipCalculator: View {
    @State private var billTotal: String = ""
    @State private var tipPercentage: Double = 15
    @State private var numberOfPeople: String = "2"

    private var totalTip: Double {
        let bill = Double(billTotal) ?? 0
        return bill * tipPercentage / 100
    }

    private var tipPerPerson: Double {
        let people = Double(numberOfPeople) ?? 1
        return totalTip / max(people, 1)
    }

    public var body: some View {
        Form {
            Section("Tip Calculator") {
                HStack {
                    Text("Bill Total")
                    Spacer()
                    TextField("0", text: $billTotal)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                }

                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(1...30, id: \.self) { number in
                        Text("^[\(number) Friend](inflect: true)").tag(
                            String(number)
                        )
                    }
                }
                .pickerStyle(.navigationLink)

            }
            Section {
                Stepper(value: $tipPercentage, in: 1...100, step: 5) {
                    Text("Tip: \(Int(tipPercentage))%")
                }
            }

            Section {
                Text("Total Tip: \(totalTip.formatted(.currency(code: "USD")))")
            }

            Section {
                Text(
                    "Tip per Person: \(tipPerPerson.formatted(.currency(code: "USD")))"
                )
            }

            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text("💡 Tip")
                        .font(.headline)
                    Text(
                        "Be generous, but smart. Even a small tip makes a big difference!"
                    )
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text("👯‍♂️ Friends")
                        .font(.headline)
                    Text(
                        "Sharing the bill with friends? Use this calculator to make it fair and simple for everyone!"
                    )
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct PeopleListView: View {
    var body: some View {
        List(2...30, id: \.self) { number in
            Text("Person \(number)")
        }
        .navigationTitle("People List")
    }
}
