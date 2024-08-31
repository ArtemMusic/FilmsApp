//
//  FriendsAppApp.swift
//  FriendsApp
//
//  Created by Artem on 8/4/24.
//

import SwiftUI

@main
struct FriendsApp: App {
    var body: some Scene {
        WindowGroup{
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
