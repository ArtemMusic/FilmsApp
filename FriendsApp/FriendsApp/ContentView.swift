//
//  ContentView.swift
//  FriendsApp
//
//  Created by Artem on 8/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Friend.birthday) private var friends: [Friend]
    @State private var newName = ""
    @State private var newDate = Date.now
    @State private var newNotes = ""
    @State private var selectedFriendID: UUID?
    
    let currentBirthday: [Friend] = []
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        
        NavigationStack{
            List(friends) { friend in
                HStack{
                    HStack {
                        if friend.isBirthdayToday {
                            Image(systemName: "birthday.cake")
                        }
                        Text(friend.name)
                            .bold(friend.isBirthdayToday)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                        Button(action: {
                            if selectedFriendID == friend.id {
                                selectedFriendID = nil
                            } else {
                                selectedFriendID = friend.id
                            }
                        }) {
                            Image(systemName: "list.clipboard")
                        }
                        .padding(5)
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    
                }
                .labelStyle(.iconOnly)
                
                if selectedFriendID == friend.id {
                    Text("Notes: \(friend.notes)")
                        .padding()
                }
            }
            .navigationTitle("All birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack (alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker (selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    TextField("Notes (optional)", text: $newNotes)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Save") {
                        if !newName.isEmpty{
                            let newFriend = Friend(name: newName, birthday: newDate, notes: newNotes)
                            context.insert(newFriend)
                            
                            newName = ""
                            newNotes = ""
                            newDate = Date.now
                        }
                    }
                    .bold()
                    .disabled(newName.isEmpty)
                    .keyboardShortcut(.cancelAction)
                }
                .padding()
                .background(.bar)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
