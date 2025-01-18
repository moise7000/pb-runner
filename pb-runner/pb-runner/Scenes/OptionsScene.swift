//
//  OptionsScene.swift
//  pb-runner
//
//  Created by ewan decima on 10/09/2024.
//


import SpriteKit
import SwiftUI

class OptionsScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        // Créer une vue SwiftUI
        let optionsView = UIHostingController(rootView: OptionsView(
            onDismiss: {
            self.returnToMainMenu()
            },
            onPlay: {
                self.play()
            }
        ))
        optionsView.view.frame = self.frame
        optionsView.view.backgroundColor = .clear
        
        // Ajouter la vue SwiftUI à la vue SpriteKit
        self.view?.addSubview(optionsView.view)
    }
    
    func returnToMainMenu() {
        let mainMenuScene = MainMenuScene(size: size)
        mainMenuScene.scaleMode = .aspectFill
        view?.presentScene(mainMenuScene, transition: .doorway(withDuration: 0.5))
        
        // Supprimer la vue SwiftUI lorsque vous quittez la scène des options
        view?.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func play() {
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = .aspectFill
        view?.presentScene(gameScene, transition: .doorway(withDuration: 0.5))
        view?.subviews.forEach { $0.removeFromSuperview() }
        
        
        
    }
    
    
    
}
