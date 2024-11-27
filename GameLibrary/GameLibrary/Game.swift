//
//  Game.swift
//  GameLibrary
//
//  Created by Master Moviles on 23/11/24.
//

import UIKit

enum Category {
    case ACTION
    case ADVENTURE
    case SHOOTER
    case SPORTS
    case SURVIVAL
}

class Game {
    let id = UUID()
    var title: String
    var coverImage: String
    var description: String
    var developer: String
    var status: String
    var category: Category
    
    init(title: String, coverImage: String, description: String, developer: String, status: String, category: Category) {
        self.title = title
        self.coverImage = coverImage
        self.description = description
        self.developer = developer
        self.status = status
        self.category = category
    }
}
