//
//  Friend.swift
//  FriendsApp
//
//  Created by Artem on 8/4/24.
//

import Foundation
import SwiftData

@Model
class Friend {
    let id: UUID
    let name: String
    let birthday: Date
    let notes: String
    
    init(name: String, birthday: Date, notes: String) {
        self.id = UUID()
        self.name = name
        self.birthday = birthday
        self.notes = notes
    }
    
    var isBirthdayToday: Bool {
        Calendar.current.isDateInToday(birthday)
    }
}
