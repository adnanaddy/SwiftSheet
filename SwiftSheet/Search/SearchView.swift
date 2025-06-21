//
//  UsersViews.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 5/29/25.
//
import SwiftUI

struct SearchView: View {
    @State private var query: String = ""
    @State private var selectedUser: Int?
    
    @State private var userToDelete: User?
    @State private var showDeleteAlert = false

    var filteredUsers: [User] {
        if query.isEmpty {
            return users
        } else {
            return users.filter {
                $0.name.lowercased().contains(query.lowercased())
                    || $0.email.lowercased().contains(query.lowercased())
            }
        }
    }
    
    private func removeUser(at offsets: IndexSet) {
        let usersToDelete = filteredUsers
        for index in offsets {
            if let matchIndex = users.firstIndex(where: { $0.id == usersToDelete[index].id }) {
                users.remove(at: matchIndex)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if filteredUsers.isEmpty {
                    Text("No user found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(filteredUsers, id: \.id) { user in
                        NavigationLink(destination: UserDetailView(user: user))
                        {
                            Label(user.name, systemImage: "person.fill")
                        }
                    }.onDelete { indexSet in
                        let usersToDelete = filteredUsers
                        if let index = indexSet.first {
                            userToDelete = usersToDelete[index]
                            showDeleteAlert = true
                        }
                    }
                }
                    
            }

            .listStyle(.plain)
            .refreshable {
                // pull to refresh action (optional)
            }
            .searchable(text: $query, prompt: "Search users")
            .navigationTitle("Search")
            .alert("Delete User?", isPresented: $showDeleteAlert, presenting: userToDelete) { user in
                Button("Delete", role: .destructive) {
                    if let matchIndex = users.firstIndex(where: { $0.id == user.id }) {
                        users.remove(at: matchIndex)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: { user in
                Text("Are you sure you want to delete \(user.name)?")
            }
            

        }
    }
}

struct UserDetailView: View {
    let user: User

    var body: some View {
        NavigationView {
            Section {
                VStack(spacing: 20) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)

                    Text("\(user.name)")
                        .font(.title)

                    Text("\(user.email)")
                        .font(.title2)
                }
            }
            .padding(20)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(12)
            .navigationTitle(user.name)
        }
    }
}
