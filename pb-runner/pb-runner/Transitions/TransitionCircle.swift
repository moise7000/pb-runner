//
//  TransitionCircle.swift
//  pb-runner
//
//  Created by ewan decima on 28/10/2024.
//

import SpriteKit
import Foundation


class TransitionCircle: SKShapeNode {
    init(radius: CGFloat) {
        super.init()
        
        // Créer un cercle parfait
        let circlePath = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2), transform: nil)
        
        self.path = circlePath
        self.fillColor = .black
        self.strokeColor = .black
        self.lineWidth = 0
        self.setScale(0.1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}





