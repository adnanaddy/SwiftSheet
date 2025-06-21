//
//  Presentations.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 6/9/25.
//

import SwiftUI

struct Alerts: View {
    var body: some View {
        Section(header: Text("Presentations")) {
            NavigationLink {
                AlertsView()
            } label: {
                Label("Alerts", systemImage: "fossil.shell")
            }
        }

    }
}

struct AlertsView: View {
    @State private var showAlert: Bool = false
    @State private var showPopoverSheet: Bool = false
    @State private var showSheet: Bool = false
    @State private var selectedFramework: String? = nil
    
    private func frameworkButton(_ name: String, systemIcon: String)
        -> some View
    {
        Button {
            selectedFramework = name
        } label: {
            Label(name, systemImage: systemIcon)
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Alert
                Button("Alert") {
                    showAlert = true
                }
                .buttonStyle(.borderedProminent)
                .alert(Text("Leaving Swift Sheet"), isPresented: $showAlert) {
                    Button("Quit", role: .destructive) {}
                } message: {
                    Text("Are you sure you want to quit this app?")
                }

                
                // Normal Sheet
                Button("Sheet") {
                    showSheet.toggle()
                }
                .buttonStyle(.bordered)
                .sheet(isPresented: $showSheet) {
                    Text("Hello")
                }
                
                // Popover
                Button("Popover Sheet") {
                    showPopoverSheet.toggle()
                }
                .buttonStyle(.borderedProminent)
                .popover(isPresented: $showPopoverSheet) {
                    NavigationStack {
                        List {
                            Section("Frameworks") {
                                frameworkButton(
                                    "SwiftUI",
                                    systemIcon: "checkmark.seal.fill"
                                )
                                frameworkButton(
                                    "Flutter",
                                    systemIcon: "checkmark.seal.fill"
                                )
                                frameworkButton(
                                    "Vue",
                                    systemIcon: "checkmark.seal.fill"
                                )
                                frameworkButton(
                                    "React",
                                    systemIcon: "checkmark.seal"
                                )
                                frameworkButton(
                                    "Laravel",
                                    systemIcon: "checkmark.seal.fill"
                                )
                                frameworkButton(
                                    "InertiaJS",
                                    systemIcon: "checkmark.seal.fill"
                                )
                                frameworkButton(
                                    "Kotlin",
                                    systemIcon: "checkmark.seal"
                                )
                                frameworkButton(
                                    "Java",
                                    systemIcon: "checkmark.seal"
                                )
                            }

                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Text("Select Frameworks")
                            }
                            ToolbarItem(placement: .automatic) {
                                Button("Done") {
                                    showPopoverSheet.toggle()
                                }
                            }
                            ToolbarItem(placement: .bottomBar) {
                                Button("Save") {
                                    showPopoverSheet.toggle()
                                }
                                .buttonStyle(.borderedProminent)
                            }

                        }
                    }

                }
            }

            .navigationTitle("Presentations")
        }
    }
}


struct FrameworkDetailView: View {
    let framework: String

    var body: some View {
        Text("\(framework) Details")
            .font(.largeTitle)
            .padding()
    }
}
