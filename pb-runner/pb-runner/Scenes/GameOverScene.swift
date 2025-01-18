//
//  GameOverScene.swift
//  pb-runner
//
//  Created by ewan decima on 10/09/2024.
//

import SpriteKit
import SwiftUI

class GameOverScene: SKScene {
    private var gameData: GameData? {
            GameDataManager.shared.getGameData()
        }
    
    override func didMove(to view: SKView) {
        
        AudioManager.shared.playBackgroundMusic(track: "gameOverSong")
        
        
        // Ajout d'un arrière-plan personnalisé
        let background = SKSpriteNode(imageNamed: "gameOverScreen")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.texture?.filteringMode = .nearest
        background.size = self.size
        
        background.zPosition = -1 // Assurez-vous que l'arrière-plan est derrière les autres éléments
        addChild(background)
        
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY + 110)
        gameOverLabel.fontName = "Invasion2000"
        gameOverLabel.fontColor = .black
        addChild(gameOverLabel)
        
        
        let currentScoreLabel = SKLabelNode(text: "You get \(gameData?.currentScore ?? -1) !")
        currentScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + 80)
        currentScoreLabel.fontName = "Invasion2000"
        currentScoreLabel.fontColor = .black
        addChild(currentScoreLabel)
        
        
        
        let highScoreLabel = SKLabelNode(text: "High Score: \(gameData?.highScore ?? -1)")
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        highScoreLabel.fontName = "Invasion2000"
        highScoreLabel.fontColor = .black
        addChild(highScoreLabel)
        
        let playAgainButton = SKLabelNode(text: "Play Again")
        playAgainButton.position = CGPoint(x: frame.midX, y: frame.midY - 20)
        playAgainButton.name = "playAgainButton"
        playAgainButton.fontName = "Invasion2000"
        playAgainButton.fontSize = 50
        playAgainButton.fontColor = .black
        addChild(playAgainButton)
        
        // Ajouter une animation de pulsation au bouton "Play Again"
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulse = SKAction.sequence([scaleUp, scaleDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        playAgainButton.run(repeatPulse)
        
        let quitButton = SKLabelNode(text: "Quit")
        quitButton.position = CGPoint(x: frame.midX - 100, y: frame.midY - 100)
        quitButton.name = "quitButton"
        quitButton.fontName = "Invasion2000"
        quitButton.fontColor = .black
        addChild(quitButton)
        
        
        let optionButton = SKLabelNode(text: "Option")
        optionButton.position = CGPoint(x: frame.midX + 100, y: frame.midY - 100)
        optionButton.name = "optionButton"
        optionButton.fontName = "Invasion2000"
        optionButton.fontColor = .black
        addChild(optionButton)
        
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        if touchedNode.name == "playAgainButton" {
            let gameScene = GameScene(size: size)
            gameScene.scaleMode = .aspectFill
            
            // Désactiver le bouton pour éviter les clics multiples
            touchedNode.isUserInteractionEnabled = false
            
            createStarTransition {
                self.view?.presentScene(gameScene)
            }
            
            
        } else if touchedNode.name == "quitButton" {
            let mainMenuScene = MainMenuScene(size: size)
            mainMenuScene.scaleMode = .aspectFill
            view?.presentScene(mainMenuScene, transition: .doorway(withDuration: 0.5))
            
        } else if touchedNode.name == "optionButton" {
        
            let optionScene = OptionsScene(size: size)
            optionScene.scaleMode = .aspectFill
            
            
            // Désactiver le bouton pour éviter les clics multiples
            touchedNode.isUserInteractionEnabled = false
            
            createCircleTransition {
                self.view?.presentScene(optionScene)
            }
            
            
        }
    }
    
    
    
    
    
    private func createStarTransition(completion: @escaping () -> Void) {
        // Paramètres de timing ajustables
        let transitionDuration: Double = 2.5  // Durée totale de la transition
        let initialDelay: Double = 0.2       // Délai avant le début des animations
        let maxStartDelay: Double = 1.0      // Délai maximum entre les étoiles
        let scaleDuration: Double = 1.8      // Durée de l'animation de grossissement
        
        let numberOfStars = 25  // Plus d'étoiles pour une transition plus fluide
        
        // Créer les étoiles en plusieurs vagues
        for i in 0..<numberOfStars {
            // Position aléatoire sur l'écran
            let randomX = CGFloat.random(in: frame.width * 0.1...frame.width * 0.9)
            let randomY = CGFloat.random(in: frame.height * 0.1...frame.height * 0.9)
            
            // Taille aléatoire pour chaque étoile
            let starSize = CGFloat.random(in: 10...30)
            let star = TransitionStar(size: starSize)
            star.position = CGPoint(x: randomX, y: randomY)
            star.zPosition = 1000 + CGFloat(i)
            addChild(star)
            
            // Animation plus élaborée
            let randomDelay = Double.random(in: 0...maxStartDelay)
            let totalDelay = initialDelay + randomDelay
            
            // Séquence d'animations
            let wait = SKAction.wait(forDuration: totalDelay)
            
            // Petite animation initiale
            let initialScale = SKAction.scale(to: 0.3, duration: 0.2)
            
            // Pause avant le grossissement principal
            let pauseDuration = 0.2
            let pause = SKAction.wait(forDuration: pauseDuration)
            
            // Animation de grossissement principale
            let scaleUp = SKAction.scale(to: 100.0, duration: scaleDuration)
            scaleUp.timingMode = .easeIn
            
            // Combiner toutes les animations
            let sequence = SKAction.sequence([
                wait,
                initialScale,
                pause,
                scaleUp
            ])
            
            // Ajouter une légère rotation pendant le grossissement
            let rotate = SKAction.rotate(byAngle: .pi * 0.5, duration: scaleDuration)
            let group = SKAction.group([sequence, rotate])
            
            star.run(group)
        }
        
        // Attendre la fin de toutes les animations avant d'appeler completion
        let totalDuration = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {
            completion()
        }
    }
    
    private func createCircleTransition(completion: @escaping () -> Void) {
        // Paramètres de timing ajustables
        let transitionDuration: Double = 2.5  // Durée totale de la transition
        let initialDelay: Double = 0.1       // Délai avant le début des animations
        let maxStartDelay: Double = 1.0      // Délai maximum entre les cercles
        let scaleDuration: Double = 1.8      // Durée de l'animation de grossissement
        
        let numberOfCircles = 25  // Nombre de cercles pour la transition
        
        // Créer les cercles
        for i in 0..<numberOfCircles {
            // Position aléatoire sur l'écran
            let randomX = CGFloat.random(in: frame.width * 0.1...frame.width * 0.9)
            let randomY = CGFloat.random(in: frame.height * 0.1...frame.height * 0.9)
            
            // Taille aléatoire pour chaque cercle
            let circleRadius = CGFloat.random(in: 5...15)
            let circle = TransitionCircle(radius: circleRadius)
            circle.position = CGPoint(x: randomX, y: randomY)
            circle.zPosition = 1000 + CGFloat(i)
            addChild(circle)
            
            // Animation plus élaborée
            let randomDelay = Double.random(in: 0...maxStartDelay)
            let totalDelay = initialDelay + randomDelay
            
            // Séquence d'animations
            let wait = SKAction.wait(forDuration: totalDelay)
            
            // Petite animation initiale avec un léger "pop"
            let initialScale = SKAction.sequence([
                SKAction.scale(to: 0.4, duration: 0.15),
                SKAction.scale(to: 0.3, duration: 0.1)
            ])
            
            // Pause avant le grossissement principal
            let pauseDuration = 0.2
            let pause = SKAction.wait(forDuration: pauseDuration)
            
            // Animation de grossissement principale avec effet d'accélération
            let scaleUp = SKAction.scale(to: 120.0, duration: scaleDuration)  // Un peu plus grand pour les cercles
            scaleUp.timingMode = .easeIn
            
            // Combiner toutes les animations
            let sequence = SKAction.sequence([
                wait,
                initialScale,
                pause,
                scaleUp
            ])
            
            circle.run(sequence)
        }
        
        // Attendre la fin de toutes les animations avant d'appeler completion
        let totalDuration = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration) {
            completion()
        }
    }
}
