//
//  GameData.swift
//  pb-runner
//
//  Created by ewan decima on 20/10/2024.
//


import SwiftData
import SpriteKit
import GameplayKit
import SwiftUI

// Définition du modèle de données
@Model
class GameData {
    var unlockedSkins: [String]
    var highScore: Int
    var currentScore: Int
    
    init(unlockedSkins: [String] = ["jump"], highScore: Int = 0, currentScore: Int = 0) {
        self.unlockedSkins = unlockedSkins
        self.highScore = highScore
        self.currentScore = currentScore
    }
}