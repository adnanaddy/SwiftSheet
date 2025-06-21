//
//  WidgetsView.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 5/29/25.
//

import SwiftUI

struct WidgetsView: View {

    var body: some View {
        NavigationView {
            List {
                Buttons()

                SfSymbols()

                Alerts()

                Section(header: Text("Sheets")) {
                    Text(
                        "This is a list of buttons that open different types of sheets."
                    )
                }

            }
            .navigationBarTitle("SwiftUI Widgets")
        }
    }
}
