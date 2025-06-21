//
//  AboutDev.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 6/21/25.
//

import SwiftUI

public struct AboutDev: View {
    public var body: some View {
        VStack(spacing: 5){
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
        }
    }
}
