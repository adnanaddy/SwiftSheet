//
//  Apps.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 6/21/25.
//

import SwiftUI

public struct AppsView: View {
    public var body: some View {
        NavigationStack {
            List {
                Section("Apps") {
                    NavigationLink {
                        SheetView()
                    } label: {
                        Label("Custom Sheet", systemImage: "hand.draw")
                    }
                    NavigationLink {
                        TipCalculator()
                    } label: {
                        Label("Tip Calculator", systemImage: "plus.minus.capsule")
                    }
                    

                }
                
                Section("Internet") {
                    NavigationLink{
                        Api()
                    } label: {
                        Label("Try Api", systemImage: "internaldrive")
                    }
                }

                Section {
                    NavigationLink {
                        AboutDev()
                    } label: {
                        Label("About Developer", systemImage: "person.crop.badge.magnifyingglass")
                    }
                }
            }

            .navigationTitle("Home")

        }

    }
}
