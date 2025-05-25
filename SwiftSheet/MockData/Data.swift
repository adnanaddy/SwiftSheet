//
//  Data.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 5/22/25.
//

import SwiftUI

struct Action: Identifiable, Hashable {
    var id: UUID = UUID()
    var image: String
    var title: String
}


let actions: [Action] = [
    .init(image: "xbox.logo", title: "Game Pass"),
    .init(image: "music.note", title: "Music"),
    .init(image: "tv.fill", title: "TV"),
    .init(image: "music.note.list", title: "Music Library"),
]

struct Period: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var value: Int
}

let periods: [Period] = [
    .init(title: "1", value: 1),
    .init(title: "3", value: 3),
    .init(title: "5", value: 5),
    .init(title: "7", value: 7),
    .init(title: "9", value: 9),
    .init(title: "Custom", value: 0),
]

struct KeyPad :Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var value: Int
    var isBack: Bool = false
}

let keyPadValues: [KeyPad] = (1...9).compactMap({ .init(title: String("\($0)"), value: $0) }) + [
    .init(title: "0", value: 0),
    .init(title: "chevron.left", value: -1, isBack: true)
]
