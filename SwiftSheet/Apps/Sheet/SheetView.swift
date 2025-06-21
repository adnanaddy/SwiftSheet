//
//  ContentView.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 5/22/25.
//

import SwiftUI

enum CurrentView {
    case actions
    case periods
    case keypad
}

struct SheetView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false // 👈 dark mode toggle (persistant)

    @State private var showSheet: Bool = false  // 👈 show/hide modal sheet
    @State private var currentView: CurrentView = .actions
    @State private var selectedAction: Action?
    @State private var selectedPeriod: Period?
    @State private var duration: String = ""
    

    var body: some View {
            VStack {
                Spacer()
                Image(systemName: "person.circle")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .padding(.bottom, 6)
                Text("Adnan Khan AdDY")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Text("Flutter & iOS Developer")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                Button("Show Swift Sheet ") {
                    showSheet.toggle()
                }
                .buttonStyle(.borderedProminent)
                .systemSheetView($showSheet) {

                    VStack(spacing: 20) {
                        ZStack {
                            switch currentView {
                            case .actions:
                                actionsView()
                                    .transition(.blurReplace)
                            case .periods:
                                periodsView()
                                    .transition(.blurReplace)
                            case .keypad:
                                keypadView()
                                    .transition(.blurReplace)
                            }
                            
                        }.compositingGroup()

                        Button {
                            withAnimation(.bouncy) {
                                if currentView == .actions {
                                    currentView = .periods
                                } else {
                                    currentView = .actions
                                }
                            }

                        } label: {
                            Text("Continue")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .foregroundStyle(.white)
                                .background(.blue, in: .capsule)
                        }.padding(.top, 15)
                    }.padding(20)
                }
                Spacer()
                HStack(spacing: 10) {
                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                        .foregroundColor(isDarkMode ? .yellow : .orange)
                        .font(.title2)
                        .transition(.scale)
                        .animation(.smooth, value: isDarkMode)

                    Toggle("", isOn: $isDarkMode)
                        .labelsHidden()
                    
                    Text(isDarkMode ? " Night" : " Day")
                        .contentTransition(.identity) // fade in/out smoothly
                        .animation(.snappy, value: isDarkMode)
                }
                .padding()
                
                Text("SwiftUI Custom Modal Sheet with\nSmooth Transitions, Interactive Multi-Step Flow,\nand Animation for iOS")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
               

            }
            .padding()
    }

    @ViewBuilder
    func actionsView() -> some View {
        VStack(spacing: 12) {
            HStack {
                Text("Choose Subscription")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer(minLength: 0)
                Button {
                    showSheet = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
                }
            }
            .padding(.bottom, 10)

            ForEach(actions) { action in
                let isSelected: Bool = selectedAction?.id == action.id

                HStack {
                    Image(systemName: action.image)
                        .font(.title)
                        .frame(width: 40)
                    Text(action.title)
                        .fontWeight(.semibold)

                    Spacer(minLength: 0)

                    Image(
                        systemName: isSelected
                            ? "checkmark.circle.fill" : "circle.fill"
                    )
                    .font(.title)
                    .contentTransition(.symbolEffect)
                    .foregroundStyle(
                        isSelected ? Color.blue : Color.gray.opacity(0.2)
                    )

                }.padding(.vertical, 6)
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedAction = isSelected ? nil : action
                        }
                    }

            }

        }
    }

    @ViewBuilder
    func periodsView() -> some View {
        VStack(spacing: 12) {
            HStack {
                Text("Choose Periods")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer(minLength: 0)
                Button {
                    withAnimation(.bouncy) {
                        currentView = .actions
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
                }
            }
            .padding(.bottom, 25)
            Text("Choose your period you want\nto get subscribed")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.bottom, 20)

            // Grid Box View
            LazyVGrid(
                columns: Array(repeating: GridItem(), count: 3),
                spacing: 15
            ) {
                ForEach(periods) { period in
                    let isSelected: Bool = selectedPeriod?.id == period.id
                    VStack(spacing: 6) {
                        Text(period.title)
                            .font(period.value == 0 ? .title3 : .title2)
                            .fontWeight(.semibold)

                        if period.value != 0 {
                            Text(period.value == 1 ? "Month" : "Months")
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(isSelected ? .blue : .gray)
                                .opacity(isSelected ? 0.2 : 0.1)
                    }
                    .contentShape(.rect)
                    .onTapGesture{
                        withAnimation(.bouncy){
                            if(period.value == 0){
                                currentView = .keypad
                            } else {
                                selectedPeriod = isSelected ? nil : period
                            }
                        }
                    }
                    
                    
                }
            }

        }
    }
    
    @ViewBuilder
    func keypadView() -> some View {
        VStack(spacing: 12) {
            HStack {
                Text("Custom Duration")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer(minLength: 0)
                Button {
                    withAnimation(.bouncy) {
                        currentView = .periods
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
                }
            }
            .padding(.bottom, 10)
            VStack(spacing: 6){
                Text(duration.isEmpty ? "0" : duration)
                    .font(.system(size: 60, weight: .black))
                    .contentTransition(.numericText())
                
                Text("Days")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 20)

            // Keypad Grid Box View
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 15) {
                ForEach(keyPadValues) { keyValue in
                    Group {
                        if keyValue.isBack {
                            Image(systemName: keyValue.title)
                        } else {
                            Text(keyValue.title)
                        }
                    }
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .contentShape(.rect)
                    .onTapGesture{
                        withAnimation(.snappy) {
                            if keyValue.isBack {
                                if !duration.isEmpty {
                                    duration.removeLast()
                                }
                            } else {
                                duration.append(keyValue.title)
                            }
                        }
                    }
                    
                    
                }
            }
            .padding(.horizontal, -15)
        }
    }
}
