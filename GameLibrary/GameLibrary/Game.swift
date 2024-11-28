//
//  Game.swift
//  GameLibrary
//
//  Created by Master Moviles on 23/11/24.
//

import UIKit
import Foundation

enum Category: String, CaseIterable {
    case Accion
    case Aventura
    case Disparos
    case Deportes
    case Supervivencia
    case Casual
    case Simulacion
    case SandBox
}

class Game: Codable {
    let title: String
    let coverImage: String
    let description: String
    let developer: String
    let status: String
    let category: String
    
    init(title: String, coverImage: String, description: String, developer: String, status: String, category: Category) {
        self.title = title
        self.coverImage = coverImage
        self.description = description
        self.developer = developer
        self.status = status
        self.category = category.rawValue
    }
}

class GameManager {
    private let gamesKey = "uniqueKey"
    
    func saveGames(_ games: [Game]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(games) {
            UserDefaults.standard.set(encodedData, forKey: gamesKey)
        }
    }
    
    func loadGames() -> [Game] {
        guard let savedData = UserDefaults.standard.data(forKey: gamesKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        if let decodedGames = try? decoder.decode([Game].self, from: savedData) {
            return decodedGames
        }
        
        return []
    }
    
}
