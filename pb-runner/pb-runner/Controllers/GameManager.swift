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


// Gestionnaire de données du jeu
class GameDataManager {
    static let shared = GameDataManager()
    
    private var modelContext: ModelContext?
    
    func initialize(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        // Créer les données initiales si nécessaire
        do {
            let descriptor = FetchDescriptor<GameData>()
            let existingData = try modelContext.fetch(descriptor)
            if existingData.isEmpty {
                let initialData = GameData()
                modelContext.insert(initialData)
                try modelContext.save()
            }
        } catch {
            print("Error initializing game data: \(error)")
        }
    }
    
    func getGameData() -> GameData? {
        guard let modelContext = modelContext else { return nil }
        do {
            let descriptor = FetchDescriptor<GameData>()
            let existingData = try modelContext.fetch(descriptor)
            return existingData.first
        } catch {
            print("Error fetching game data: \(error)")
            return nil
        }
    }
    
    func save() {
        guard let modelContext = modelContext else { return }
        do {
            try modelContext.save()
        } catch {
            print("Error saving game data: \(error)")
        }
    }
}
