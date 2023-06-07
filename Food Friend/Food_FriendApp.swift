//
//  Food_FriendApp.swift
//  Food Friend
//
//  Created by Tristan on 07/06/2023.
//

import SwiftUI
import SwiftData

@main
struct Food_FriendApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
