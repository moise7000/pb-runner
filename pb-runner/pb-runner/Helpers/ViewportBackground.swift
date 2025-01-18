//
//  ViewportBackground.swift
//  pb-runner
//
//  Created by ewan decima on 10/01/2025.
//

import SpriteKit
import Foundation





class ViewportBackground: SKNode {
    private var backgroundLayers: [SKCropNode] = []
    private var layerSprites: [SKSpriteNode] = []
    private var viewportWidth: CGFloat = 256
    private let layerSpeeds: [CGFloat]
    private let sceneHeight: CGFloat
    private let needsZoom: Bool
    private let zoomFactorForMob: CGFloat = 1.5
    
    init(backgroundName: String, numberOfLayers: Int, layerSpeeds: [CGFloat], sceneHeight: CGFloat, needsZoom: Bool) {
        self.layerSpeeds = layerSpeeds
        self.sceneHeight = sceneHeight
        self.needsZoom = needsZoom
        super.init()
        setupLayers(backgroundName: backgroundName, numberOfLayers: numberOfLayers)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayers(backgroundName: String, numberOfLayers: Int) {
        for i in 0..<numberOfLayers {
            let layerName = "\(backgroundName)_layer\(i+1)"
            let backgroundTexture = SKTexture(imageNamed: layerName)
            backgroundTexture.filteringMode = .nearest
            
            // Créer le sprite de la couche
            let layerSprite = SKSpriteNode(texture: backgroundTexture)
            if needsZoom {
                layerSprite.size = CGSize(width: backgroundTexture.size().width * zoomFactorForMob,
                                        height: sceneHeight)
            } else {
                layerSprite.size = CGSize(width: backgroundTexture.size().width,
                                        height: sceneHeight)
            }
            
            // Créer le masque (viewport)
            let maskNode = SKSpriteNode(color: .white, size: CGSize(width: viewportWidth, height: sceneHeight))
            
            // Créer le nœud de recadrage
            let cropNode = SKCropNode()
            cropNode.maskNode = maskNode
            cropNode.position = CGPoint(x: 0, y: 0)
            cropNode.zPosition = -CGFloat(numberOfLayers - i)
            
            // Ajouter le sprite au nœud de recadrage
            layerSprite.position = CGPoint(x: viewportWidth/2, y: sceneHeight/2)
            cropNode.addChild(layerSprite)
            
            // Stocker les références
            backgroundLayers.append(cropNode)
            layerSprites.append(layerSprite)
            
            // Ajouter à la scène
            addChild(cropNode)
        }
    }
    
    func update(baseSpeed: CGFloat) {
        // Mettre à jour la position de chaque couche
        for (index, sprite) in layerSprites.enumerated() {
            guard index < layerSpeeds.count else { continue }
            
            let layerSpeed = baseSpeed * layerSpeeds[index]
            sprite.position.x -= layerSpeed
            
            // Vérifier si nous devons réinitialiser la position
            if sprite.position.x <= -sprite.size.width + viewportWidth {
                sprite.position.x = viewportWidth/2
            }
        }
    }
}
