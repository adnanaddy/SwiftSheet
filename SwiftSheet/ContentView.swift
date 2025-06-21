//
//  ContentView.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 5/22/25.
//

import SwiftUI

struct TabsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        TabView {
            Tab("Apps", systemImage: "circle.hexagongrid") {
                AppsView()
            }

            Tab("Search", systemImage: "magnifyingglass") {
                SearchView()
            }

            Tab("Widgets", systemImage: "circle.grid.2x2") {
                WidgetsView()
            }

            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }

        }.tabViewStyle(.automatic)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

}

#Preview {
    TabsView()
}

enum ColorSchemeOption: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: String { rawValue }
    var displayName: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}
