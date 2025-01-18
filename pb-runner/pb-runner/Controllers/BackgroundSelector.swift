//
//  BackgroundSelector.swift
//  pb-runner
//
//  Created by ewan decima on 22/09/2024.
//


import SwiftUI



struct BackgroundSelector: View {
    @Binding var selectedBackgroundSkin: String
    @Binding var backgroundNeedZoom: Bool
    
    let skins = [
        BackgroundSkinParalax(
            id: 1,
            name: "Les Arcs",
            imageName: "LesArcs",
            needZoom: false,
            numberOfLayers: 6,
            layerSpeeds: [0.1, 0.2, 0.3, 0.4, 0.5, 0.6],
            mainTheme: "mainMenuSong"
        ),
        
        BackgroundSkinParalax(
            id: 2,
            name: "Dordogne",
            imageName: "Dordogne2",
            needZoom: false,
            numberOfLayers: 7,
            layerSpeeds: [0.1, 0.2, 0.3, 0.4, 0.2, 0.4, 0.5],
            mainTheme: "mainMenuSong"
        ),
        
        BackgroundSkinParalax(
                    id: 3,
                    name: "Lascaux",
                    imageName: "Lascaux",
                    needZoom: false,
                    numberOfLayers: 2,
                    layerSpeeds: [0.2, 0.5],
                    mainTheme: "mainMenuSong"
                ),

        
        BackgroundSkinParalax(
                    id: 4,
                    name: "Snow",
                    imageName: "snow",
                    needZoom: false,
                    numberOfLayers: 5,
                    layerSpeeds: [0.1, 0.2, 0.3, 0.4, 0.5],
                    mainTheme: "mainMenuSong"
                )
        
        
        
        
        
        
        
        
    ]
    
    var body: some View {
        VStack {
            Text("Select Background")
                .font(.custom("Invasion2000", size: 40))
                .font(.largeTitle)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(skins) { skin in
                        VStack {
                            Image(skin.imageName)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 256 * 0.75, height: 128 * 0.75)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedBackgroundSkin == skin.imageName ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    selectedBackgroundSkin = skin.imageName
                                    backgroundNeedZoom = skin.needZoom
                                }
                            
                            Text(skin.name)
                                .font(.custom("Invasion2000", size: 15))
                                .font(.caption)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

