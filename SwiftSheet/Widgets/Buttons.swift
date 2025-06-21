//
//  Buttons.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 6/9/25.
//



import SwiftUI


struct Buttons: View {
    var body: some View {
        Section(
            header: Text("Buttons"),
            footer: Text(
                "This section displays commonly used button styles."
            )
        ) {
            ForEach(ButtonType.allCases, id: \.self) { type in
                NavigationLink {
                    ButtonView(type: type)
                } label: {
                    Label(type.rawValue.capitalized + " Button", systemImage: iconForType(type))
                }
            }
        }
    }
}

struct ButtonView: View {
    let type: ButtonType

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(type.title)
                    .font(.title2)

                // Show the actual button
                Group {
                    switch type {
                    case .primary:
                        Button("Primary") { }
                            .buttonStyle(.borderedProminent)

                    case .secondary:
                        Button("Secondary") { }
                            .buttonStyle(.bordered)

                    case .plain:
                        Button("Plain") { }
                            .buttonStyle(.plain)

                    case .destructive:
                        Button("Destructive") { }
                            .foregroundColor(.red)
                            .buttonStyle(.bordered)

                    case .cancel:
                        Button(role: .cancel) {
                            // Cancel action
                        } label: {
                            Text("Cancel")
                        }

                    case .iconOnly:
                        Button(action: {}) {
                            Image(systemName: "gear")
                        }
                        .accessibilityLabel("Settings")
                    }
                }
                .padding(.bottom)

                // Code snippet
                Text("Code:")
                    .font(.headline)

                ScrollView(.horizontal) {
                    Text(type.code)
                        .font(.system(.body, design: .monospaced)) // fixed width font
                        .textSelection(.enabled) // allow copy
                        .padding()
                        .background(Color.black.opacity(0.05)) // light code background
                        .cornerRadius(8)
                        .overlay( // optional border
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2))
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical)
                

                Spacer()
            }
            .padding()
        }
    }
}

enum ButtonType: String, CaseIterable {
    case primary, secondary, plain, destructive, cancel, iconOnly

    var title: String {
        rawValue.capitalized + " Button"
    }

    var systemImage: String {
        switch self {
        case .primary: return "checkmark.circle.fill"
        case .secondary: return "square.and.pencil"
        case .plain: return "doc.plaintext"
        case .destructive: return "trash"
        case .cancel: return "xmark.circle"
        case .iconOnly: return "gearshape.fill"
        }
    }

    var code: String {
        switch self {
        case .primary:
            return #".buttonStyle(.borderedProminent)"#
        case .secondary:
            return #".buttonStyle(.bordered)"#
        case .plain:
            return #"buttonStyle(.plain)"#
        case .destructive:
            return #".foregroundColor(.red)\n    .buttonStyle(.bordered)"#
        case .cancel:
            return #"Text("Cancel")\n}"#
        case .iconOnly:
            return #"Image(systemName: "gear")\n}"#
        }
    }
}


func iconForType(_ type: ButtonType) -> String {
    switch type {
    case .primary: return "checkmark.circle.fill"
    case .secondary: return "square.and.pencil"
    case .plain: return "doc.plaintext"
    case .destructive: return "trash"
    case .cancel: return "xmark.circle"
    case .iconOnly: return "gearshape.fill"
    }
}
