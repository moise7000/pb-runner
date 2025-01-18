//
//  SceneModel.swift
//  pb-runner
//
//  Created by ewan decima on 12/10/2024.
//

import Foundation
import SpriteKit
import GameplayKit


struct BackgroundSkin : Identifiable {
    let id : Int
    let name: String
    let imageName: String
    var needZoom: Bool
}



struct BackgroundSkinUpdated : Identifiable {
    let id : Int
    let name: String
    let imageName: String
    var needZoom: Bool
    var groundName: String
}


struct BackgroundSkinParalax: Identifiable {
    let id: Int
    let name: String
    let imageName: String
    var needZoom: Bool
    let numberOfLayers: Int
    var layerSpeeds: [CGFloat]
    
    var mainTheme: String
    
    
    init(id: Int, name: String, imageName: String, needZoom: Bool, numberOfLayers: Int, layerSpeeds: [CGFloat], mainTheme: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.needZoom = needZoom
        self.numberOfLayers = numberOfLayers
        
        if layerSpeeds.count == numberOfLayers {
            self.layerSpeeds = layerSpeeds
        } else {
            self.layerSpeeds = (0..<numberOfLayers).map { CGFloat($0 + 1) / CGFloat(numberOfLayers) }
        }
        
        
        self.mainTheme = mainTheme
        
    }
}

 
