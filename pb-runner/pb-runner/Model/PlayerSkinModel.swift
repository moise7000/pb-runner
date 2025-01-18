//
//  SkinModel.swift
//  pb-runner
//
//  Created by ewan decima on 22/09/2024.
//

import Foundation


enum UnlockType {
    case score(Int)
    case purchase(Double)
}


struct PlayerSkin: Identifiable, Codable {
    let id = UUID()
    let name: String
    let imageName: String
    let requiredScore: Int
    
}


