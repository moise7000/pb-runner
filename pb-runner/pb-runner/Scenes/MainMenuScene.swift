import SpriteKit



class MainMenuScene: SKScene {
    private var backgroundLayers: [SKSpriteNode] = []
    private let parallaxSkin = BackgroundSkinParalax(
        id: 1,
        name: "Title Background",
        imageName: "titleScreen",
        needZoom: false,
        numberOfLayers: 6,
        layerSpeeds: [0.2, 0.3, 0.4, 0.6, 0.8, 0.1],
        mainTheme: "mainMenuSong"
    )
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "titleScreen_layer1")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.texture?.filteringMode = .nearest
        background.size = self.size
        background.zPosition = -100
        addChild(background)
        
        
        setupParallaxBackground()
        
        // On attend que l'animation des layers soit terminée avant d'afficher l'UI
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // 2.0 est la durée la plus longue d'animation
            self.setupUI()
        }
        
        //MARK: Songs
        if !AudioManager.shared.same(as: "mainMenuSong") {
            AudioManager.shared.playBackgroundMusic(track: "mainMenuSong")
        }
        
        
    }
    
    private func setupParallaxBackground() {
        // Créer les différentes couches
        
        let n = parallaxSkin.numberOfLayers
        
        
        
        for i in 2..<parallaxSkin.numberOfLayers {
            let layerName = "\(parallaxSkin.imageName)_layer\(i+1)"
        
            let layer = SKSpriteNode(imageNamed: layerName)
            layer.texture?.filteringMode = .nearest
            
            // Configurer la taille
            layer.size = self.size
            
            // Position initiale (en bas de l'écran)
            layer.position = CGPoint(x: frame.midX, y: frame.midY - self.size.height)
            layer.zPosition = CGFloat(-parallaxSkin.numberOfLayers + i)
            
            addChild(layer)
            backgroundLayers.append(layer)
            
            // Animer la couche vers sa position finale
            animateLayerEntry(layer, speed: parallaxSkin.layerSpeeds[i])
        }
    }
    
    private func animateLayerEntry(_ layer: SKSpriteNode, speed: CGFloat) {
        // Calculer la durée en fonction de la vitesse (plus la vitesse est élevée, plus c'est rapide)
        let duration = 2.0 * (1.0 - speed) // Duration entre 0.4s et 1.2s selon la vitesse
        
        // Animation avec effet de ralentissement à la fin
        let moveUp = SKAction.moveTo(y: frame.midY, duration: duration)
        moveUp.timingMode = .easeOut // Ralentissement à la fin
        
        layer.run(moveUp)
    }
    
    private func setupUI() {
            let playButton = SKLabelNode(text: "Play")
            playButton.position = CGPoint(x: frame.midX, y: frame.midY + 50)
            playButton.name = "playButton"
            playButton.fontName = "Invasion2000"
            playButton.fontSize = 50
            playButton.alpha = 0 // Commence invisible
            addChild(playButton)
            
            let optionsButton = SKLabelNode(text: "Options")
            optionsButton.position = CGPoint(x: frame.midX, y: frame.midY - 10)
            optionsButton.name = "optionsButton"
            optionsButton.fontName = "Invasion2000"
            optionsButton.alpha = 0 // Commence invisible
            addChild(optionsButton)
            
            let creditsButton = SKLabelNode(text: "Credits")
            creditsButton.position = CGPoint(x: frame.midX, y: frame.midY - 70) // Positionné sous Options
            creditsButton.name = "creditsButton"
            creditsButton.fontName = "Invasion2000"
            creditsButton.alpha = 0 // Commence invisible
            addChild(creditsButton)
            
            // Fade in des boutons
            let fadeIn = SKAction.fadeIn(withDuration: 0.5)
            playButton.run(fadeIn)
            optionsButton.run(fadeIn)
            creditsButton.run(fadeIn)
            
            // Animation de pulsation pour le bouton Play
            let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
            let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
            let pulse = SKAction.sequence([scaleUp, scaleDown])
            let repeatPulse = SKAction.repeatForever(pulse)
            playButton.run(SKAction.sequence([fadeIn, repeatPulse]))
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "playButton" {
                let gameScene = GameScene(size: size)
                gameScene.scaleMode = .aspectFit
                touchedNode.isUserInteractionEnabled = false
                createStarTransition {
                    self.view?.presentScene(gameScene)
                }
            } else if touchedNode.name == "optionsButton" {
                let optionsScene = OptionsScene(size: size)
                optionsScene.scaleMode = .aspectFill
                touchedNode.isUserInteractionEnabled = false
                createCircleTransition {
                    self.view?.presentScene(optionsScene)
                }
            } else if touchedNode.name == "creditsButton" {
                let creditsScene = CreditsScene(size: size)
                creditsScene.scaleMode = .aspectFit
                touchedNode.isUserInteractionEnabled = false
                createCircleTransition {
                    self.view?.presentScene(creditsScene)
                }
            }
        }
    
    
    
    
    
    
    
    
    
    func createStarTransition(completion: @escaping () -> Void) {
    // Paramètres de timing ajustables
    let transitionDuration: Double = 2.5  // Durée totale de la transition
    let initialDelay: Double = 0.2       // Délai avant le début des animations
    let maxStartDelay: Double = 1.0      // Délai maximum entre les étoiles
    let scaleDuration: Double = 1.3      // Durée de l'animation de grossissement
    
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
        let pauseDuration = 0.01
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
        print(totalDuration)
    }
}
    
    func createCircleTransition(completion: @escaping () -> Void) {
        // Paramètres de timing ajustables
        let transitionDuration: Double = 2.0  // Durée totale de la transition
        let initialDelay: Double = 0.5       // Délai avant le début des animations
        let maxStartDelay: Double = 1.0      // Délai maximum entre les cercles
        let scaleDuration: Double = 0.5     // Durée de l'animation de grossissement
        
        let numberOfCircles = 20  // Nombre de cercles pour la transition
        
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
                SKAction.scale(to: 0.4, duration: 0.10),
                SKAction.scale(to: 0.3, duration: 0.1)
            ])
            
            // Pause avant le grossissement principal
            let pauseDuration = 0.1
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
