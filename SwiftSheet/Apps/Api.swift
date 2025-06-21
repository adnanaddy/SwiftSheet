//
//  AboutDev.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 6/21/25.
//
import SwiftUI

// MARK: - Model
struct Person: Identifiable, Decodable, Hashable {
    let name: String
    let thumbnailURL: String

    // Computed ID from name + thumbnail
    var id: Int { hashValue }

    enum CodingKeys: String, CodingKey {
        case name, picture
    }

    enum NameKeys: String, CodingKey {
        case first, last
    }

    enum PictureKeys: String, CodingKey {
        case thumbnail
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let nameContainer = try container.nestedContainer(keyedBy: NameKeys.self, forKey: .name)
        let first = try nameContainer.decode(String.self, forKey: .first)
        let last = try nameContainer.decode(String.self, forKey: .last)
        name = "\(first) \(last)"

        let pictureContainer = try container.nestedContainer(keyedBy: PictureKeys.self, forKey: .picture)
        thumbnailURL = try pictureContainer.decode(String.self, forKey: .thumbnail)
    }
}

struct PeopleResponse: Decodable {
    let results: [Person]
}

// MARK: - View
public struct Api: View {
    @State private var people: [Person] = []
    @State private var isLoading = false

    public var body: some View {
        NavigationView {
            List {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    ForEach(people) { person in
                        HStack {
                            AsyncImage(url: URL(string: person.thumbnailURL)) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable().scaledToFill()
                                default:
                                    Color.gray.opacity(0.3)
                                }
                            }
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())

                            Text(person.name).bold()
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deletePerson)
                }
            }
            .refreshable {
                loadPeople()
            }
            .onAppear(perform: loadPeople)
        }
    }

    private func deletePerson(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
    }

    private func loadPeople() {
        isLoading = true
        Task {
            do {
                let url = URL(string: "https://randomuser.me/api/?results=10")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(PeopleResponse.self, from: data)
                people = decoded.results
            } catch {
                print("Error loading people:", error)
                people = []
            }
            isLoading = false
        }
    }
}
