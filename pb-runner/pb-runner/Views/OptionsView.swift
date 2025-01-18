import SwiftUI

struct OptionsView: View {
    @AppStorage("selectedSkin") private var selectedSkin = "jump"
    @AppStorage("selectedBackgroundSkin") private var selectedBackgroundSkin = "blurSky"
    @AppStorage("backgroundNeedZoom") private var backgroundNeedZoom = false
    
    var onDismiss: () -> Void
    var onPlay: () -> Void
    
    
    
    @State private var musicVolume: Double = AudioManager.shared.musicVolume
    
    @State private var soundVolume = 0.5
    
    private var gameData: GameData? {
            GameDataManager.shared.getGameData()
        }
    
    private var highScore: Int {
        get { gameData?.highScore ?? 0 }
        set {
            gameData?.highScore = newValue
            GameDataManager.shared.save()
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("mainMenu")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        
                        
                        //MARK: Player Customization
                        VStack(alignment: .leading) {
                            Text("Player Customization")
                                .font(.custom("Invasion2000", size: 20))
                                .foregroundColor(.white)
                            PlayerSkinSelector(selectedSkin: $selectedSkin)
                        }
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        
                        
                        
                        
                        //MARK: Player Customization
                        VStack(alignment: .leading) {
                            Text("Background Customization")
                                .font(.custom("Invasion2000", size: 20))
                                .foregroundColor(.white)
                            BackgroundSelector(selectedBackgroundSkin: $selectedBackgroundSkin, backgroundNeedZoom: $backgroundNeedZoom)
                        }
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        
                        
                        //MARK: Control Customisation
                        VStack(alignment: .leading) {
                            Text("Control Customization")
                                .font(.custom("Invasion2000", size: 20))
                                .foregroundColor(.white)
                            ControlSelector()
                        }
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)

                        
                        
                        
                        //MARK: Audio Settings
                        VStack(alignment: .leading) {
                            Text("Audio Settings")
                                .font(.custom("Invasion2000", size: 20))
                                .foregroundColor(.white)
                            
                            
                            
                            VStack {
                                Text("Music Volume")
                                    .font(.custom("Invasion2000", size: 16))
                                    .foregroundColor(.white)
                                Slider(value: $musicVolume, in: 0...1, step: 0.1) { _ in
                                    AudioManager.shared.setMusicVolume(musicVolume)
                                }
                                    .accentColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        
                        // Score Settings
                        VStack(alignment: .leading) {
                            Text("Score Settings")
                                .font(.custom("Invasion2000", size: 20))
                                .foregroundColor(.white)
                            
                            Text("Current High Score: \(gameData?.highScore ?? 0)")
                                .font(.custom("Invasion2000", size: 16))
                                .foregroundColor(.white)
                            
                            Button(action: {
                                if (gameData != nil) {
                                    gameData?.highScore = 0
                                    
                                    gameData?.unlockedSkins = ["jump"]
                                    selectedSkin = "jump"
                                    GameDataManager.shared.save()
                                }
                                
                                
                                
                                
                                
                            }) {
                                Text("Reset high score")
                                    .font(.custom("Invasion2000", size: 14))
                                    .foregroundColor(.red)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(5)
                            }
                            .disabled(gameData == nil)
                        }
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Options", displayMode: .inline)
            
            .navigationBarItems(
                leading: Button(action: onDismiss) {
                Text("Back")
                    .font(.custom("Invasion2000", size: 14))
                    .foregroundColor(.red)
            },
                trailing: Button(action: onPlay) {
                    Text("Play")
                        .font(.custom("Invasion2000", size: 14))
                        .foregroundStyle(.green)
                }
            
            )
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
