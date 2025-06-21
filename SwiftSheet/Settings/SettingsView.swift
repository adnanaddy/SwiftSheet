//
//  SettingsView.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 5/29/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var isNotificationsOn: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    let imageUrl = URL(string: "https://randomuser.me/api/portraits/men/\(Int.random(in: 1...99)).jpg")

    var body: some View {
        NavigationView {
            List {
                Group {
                    HStack(spacing: 16) {
                        AsyncImage(url: imageUrl) { image in
                                   image
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width: 60, height: 60)
                                       .clipShape(Circle())
                               } placeholder: {
                                   Image(systemName: "person.circle.fill")
                                          .resizable()
                                          .scaledToFit()
                                          .frame(width: 60, height: 60)
                                          .foregroundColor(.gray)
                                          .clipShape(Circle())
                               }
                        VStack(alignment: .leading) {
                            Text("Adnan Khan")
                                .font(.title2)
                            Text("adnan@gmail.com")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 6)
                }
                Button {

                } label: {
                    HStack {
                        Text("Edit Profile")
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
                Section("Notification") {
                    Toggle("Enable notifications", isOn: $isNotificationsOn)
                }
                Section("Security") {
                    Label("Change Password", systemImage: "lock")
                    Label(
                        "Two-Factor Authentication",
                        systemImage: "lock.shield"
                    )
                }
                Section("Appearance") {
                    Toggle(isOn: $isDarkMode) {
                        Label(
                            "Dark Mode",
                            systemImage: isDarkMode ? "moon.fill" : "sun.max"
                        )
                    }
                }
                Section("Advanced") {
                    NavigationLink {
                        VStack(spacing: 4) {
                            Text("Adnan Khan")
                                .font(.title)
                                .foregroundColor(.blue)
                            Text("Flutter & iOS Developer")
                                .font(.callout)
                            Link(
                                "adnan@gmail.com",
                                destination: URL(
                                    string: "mailto:adnan@gmail.com"
                                )!
                            )
                            Link(
                                "+92 346 945 1513",
                                destination: URL(string: "tel:03469451513")!
                            )
                        }
                        .navigationTitle("About Developer")

                    } label: {
                        Label("About", systemImage: "info.circle")
                    }

                    Label("Language", systemImage: "globe")
                    Label("Help", systemImage: "questionmark.circle")
                    Label("Feedback", systemImage: "message.circle")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
