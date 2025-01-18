//
//  CreditsScene.swift
//  pb-runner
//
//  Created by ewan decima on 14/01/2025.
//


import SpriteKit

class CreditsScene: SKScene {
    private var scrollingContainer: SKNode?
    private var backgroundLayers: [SKSpriteNode] = []
    private let scrollSpeed: CGFloat = 75.0
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupScrollingCredits()
        setupBackButton()
        
        AudioManager.shared.playBackgroundMusic(track: "gameOverSong")
    }
    
    private func setupBackground() {
        let background = SKSpriteNode(imageNamed: "creditsScreen")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.texture?.filteringMode = .nearest
        background.size = self.size
        background.zPosition = -100
        addChild(background)
    }
    
    private func setupScrollingCredits() {
        // Container pour le texte défilant
        scrollingContainer = SKNode()
        guard let scrollingContainer = scrollingContainer else { return }
        scrollingContainer.position = CGPoint(x: frame.midX, y: -frame.height)
        addChild(scrollingContainer)
        
        // Tableau des crédits
        let credits = [
            ("Special thanks", ["to all my friends"]),
            ("Art", ["Arthur Jublot Margarit", "@sacha_banak", "Etienne Marec",  "Leo Front", "Timygamedesigner"]),
            ("Music", ["Jules Jublot"]),
            ("Programming", ["Ewan Decima"])
        ]
        
        var currentY: CGFloat = 240
        let spacing: CGFloat = 40
        let categorySpacing: CGFloat = 80
        
        print(credits)
        
        // Création des textes de crédits
        for (category, names) in credits {
            let categoryLabel = SKLabelNode(text: category)
            categoryLabel.fontName = "Invasion2000"
            categoryLabel.fontSize = 40
            categoryLabel.position = CGPoint(x: 0, y: currentY)
            scrollingContainer.addChild(categoryLabel)
            
            currentY -= spacing
            
            for name in names {
                let nameLabel = SKLabelNode(text: name)
                nameLabel.fontName = "Invasion2000"
                nameLabel.fontSize = 30
                nameLabel.position = CGPoint(x: 0, y: currentY)
                scrollingContainer.addChild(nameLabel)
                currentY -= spacing
            }
            
            currentY -= categorySpacing
        }
        
        // Animation de défilement
        let moveUp = SKAction.moveBy(x: 0, y: frame.height * 3, duration: TimeInterval(frame.height * 3 / scrollSpeed))
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let sequence = SKAction.sequence([moveUp, fadeOut])
        
        scrollingContainer.run(sequence) {
            self.returnToMainMenu()
        }
    }
    
    private func setupBackButton() {
        let backButton = SKLabelNode(text: "Back")
        backButton.fontName = "Invasion2000"
        backButton.fontSize = 20
        
        backButton.position = CGPoint(x: frame.width * 0.1, y: frame.height * 0.9)
        backButton.name = "backButton"
        addChild(backButton)
        
        // Animation de pulsation pour le bouton
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulse = SKAction.sequence([scaleUp, scaleDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        backButton.run(repeatPulse)
    }
    
    private func returnToMainMenu() {
        let mainMenu = MainMenuScene(size: size)
        mainMenu.scaleMode = .aspectFit
        
        createCircleTransition {
            self.view?.presentScene(mainMenu)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        if touchedNode.name == "backButton" {
            returnToMainMenu()
        }
    }
    
    // Réutilisation de la transition en cercle du code original
    func createCircleTransition(completion: @escaping () -> Void) {
        let transitionDuration: Double = 2.0
        let initialDelay: Double = 0.5
        let maxStartDelay: Double = 1.0
        let scaleDuration: Double = 0.5
        
        let numberOfCircles = 20
        
        for i in 0..<numberOfCircles {
            let randomX = CGFloat.random(in: frame.width * 0.1...frame.width * 0.9)
            let randomY = CGFloat.random(in: frame.height * 0.1...frame.height * 0.9)
            
            let circleRadius = CGFloat.random(in: 5...15)
            let circle = TransitionCircle(radius: circleRadius)
            circle.position = CGPoint(x: randomX, y: randomY)
            circle.zPosition = 1000 + CGFloat(i)
            addChild(circle)
            
            let randomDelay = Double.random(in: 0...maxStartDelay)
            let totalDelay = initialDelay + randomDelay
            
            let wait = SKAction.wait(forDuration: totalDelay)
            
            let initialScale = SKAction.sequence([
                SKAction.scale(to: 0.4, duration: 0.10),
                SKAction.scale(to: 0.3, duration: 0.1)
            ])
            
            let pause = SKAction.wait(forDuration: 0.1)
            
            let scaleUp = SKAction.scale(to: 120.0, duration: scaleDuration)
            scaleUp.timingMode = .easeIn
            
            let sequence = SKAction.sequence([
                wait,
                initialScale,
                pause,
                scaleUp
            ])
            
            circle.run(sequence)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion()
        }
    }
}
