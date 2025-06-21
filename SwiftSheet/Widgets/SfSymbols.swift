//
//  SfSymbols.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 6/9/25.
//


import SwiftUI

struct SfSymbols: View {
    var body: some View {
        Section(header: Text("Icons"), footer: Text("Apple Icons (System Images)")) {
            NavigationLink {
                SearchIcons()
            } label : {
                Label("SF Symbols", systemImage: "applelogo")
            }
        }
    }
}


struct SearchIcons: View {
    @State private var searchText = ""

    // Sample list — You can replace with more symbols
    let allIcons = [
        // Basic UI
        "house", "gear", "person", "bell", "heart", "star", "trash", "folder",
        "paperplane", "magnifyingglass", "pencil", "plus", "minus", "checkmark",
        "xmark", "envelope", "calendar", "camera", "clock", "globe", "tag",
        
        // Navigation & Actions
        "arrow.left", "arrow.right", "arrow.up", "arrow.down",
        "arrow.backward", "arrow.forward", "square.and.arrow.up",
        "square.and.arrow.down", "chevron.left", "chevron.right",
        "chevron.up", "chevron.down", "ellipsis", "ellipsis.circle",
        
        // Media
        "play.fill", "pause.fill", "stop.fill", "backward.fill",
        "forward.fill", "speaker.wave.2.fill", "mic.fill", "headphones",
        
        // Devices & System
        "iphone", "ipad", "macbook", "applewatch", "battery.100",
        "wifi", "bluetooth", "lock.fill", "faceid", "touchid",
        
        // People & Communication
        "person.fill", "person.2.fill", "message", "phone", "video",
        "bubble.left.fill", "text.bubble", "at", "location", "map",
        
        // Misc
        "doc.fill", "doc.text", "bookmark", "flag", "cart", "creditcard",
        "photo", "folder.fill", "link", "eye", "eye.slash", "star.fill",
        "square", "circle", "square.grid.2x2", "slider.horizontal.3"
    ]

    var filteredIcons: [String] {
        if searchText.isEmpty {
            return allIcons
        } else {
            return allIcons.filter {
                $0.contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        List(filteredIcons, id: \.self) { iconName in
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .frame(width: 30)
                Text(iconName)
                    .font(.body.monospaced())
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText, prompt: "Search SF Symbols")
        .navigationTitle("Search")
    }
}
