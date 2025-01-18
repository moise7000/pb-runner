//
//  TransitionStar.swift
//  pb-runner
//
//  Created by ewan decima on 28/10/2024.
//


import SpriteKit

class TransitionStar: SKShapeNode {
    init(size: CGFloat) {
        super.init()
        
        // Créer une étoile à 5 branches remplie
        let path = UIBezierPath()
        let angle = CGFloat(.pi / 5.0)
        let outerRadius = size
        let innerRadius = size * 0.4
        
        var currentAngle = CGFloat(-CGFloat.pi / 2.0)
        
        let firstX = cos(currentAngle) * outerRadius
        let firstY = sin(currentAngle) * outerRadius
        path.move(to: CGPoint(x: firstX, y: firstY))
        
        for i in 0..<5 {
            currentAngle += angle
            var nextX = cos(currentAngle) * innerRadius
            var nextY = sin(currentAngle) * innerRadius
            path.addLine(to: CGPoint(x: nextX, y: nextY))
            
            currentAngle += angle
            nextX = cos(currentAngle) * outerRadius
            nextY = sin(currentAngle) * outerRadius
            path.addLine(to: CGPoint(x: nextX, y: nextY))
        }
        
        path.close()
        
        self.path = path.cgPath
        self.fillColor = .black
        self.strokeColor = .black
        self.lineWidth = 0
        self.setScale(0.1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func reverseStarTransition(size: CGSize, duration: TimeInterval) -> SKTransition {
        let scene = SKScene(size: size)
        scene.backgroundColor = .black
        
        // Configuration de l'effet de particules
        let starEmitter = SKEmitterNode(fileNamed: "ReverseStarParticle")
        starEmitter?.position = CGPoint(x: size.width / 2, y: size.height / 2)
        starEmitter?.particleScale = 0.05
        starEmitter?.particleScaleSpeed = 1.0  // Augmentation rapide de la taille des étoiles
        
        if let starEmitter = starEmitter {
            scene.addChild(starEmitter)
        }
        
        // Création de la transition en fondu
        let transition = SKTransition.fade(withDuration: duration)
        transition.pausesIncomingScene = false
        return transition
    }
    
    
}




