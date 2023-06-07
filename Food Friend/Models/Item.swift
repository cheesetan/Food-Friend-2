//
//  Item.swift
//  Food Friend
//
//  Created by Tristan on 07/06/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
