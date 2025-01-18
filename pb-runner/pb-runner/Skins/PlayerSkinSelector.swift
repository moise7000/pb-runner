import SwiftUI



struct PlayerSkinSelector: View {
    @Binding var selectedSkin: String
    
    private var gameData: GameData? {
            GameDataManager.shared.getGameData()
        }
    
    static let skins = [
        PlayerSkin(name: "Lombric", imageName: "jump", requiredScore: 0),
        PlayerSkin(name: "Mister MST", imageName: "jumpMst", requiredScore: 2),
        PlayerSkin(name: "Tata Clope", imageName: "jumpTataClope", requiredScore: 9),
        PlayerSkin(name: "Tonton Clope", imageName: "jumpTontonClope", requiredScore: 9),
        PlayerSkin(name: "Maman", imageName: "jumpMaman", requiredScore: 7),
        PlayerSkin(name: "The Crown", imageName: "jumpCrown", requiredScore: 5),
        PlayerSkin(name: "Ghost Face", imageName: "jumpGhost", requiredScore: 10),
        PlayerSkin(name: "Green Master", imageName: "jumpGreen", requiredScore: 15),
        PlayerSkin(name: "Purple Gum", imageName: "jumpPurple", requiredScore: 30),
        PlayerSkin(name: "Blue Slime", imageName: "jumpSlimeLombric", requiredScore: 35),
        PlayerSkin(name: "Orange Juice", imageName: "jumpOrange", requiredScore: 40),
        PlayerSkin(name: "Red Dragon", imageName: "jumpRedDragon", requiredScore: 45),
        PlayerSkin(name: "Snow Man", imageName: "jumpSnowman", requiredScore: 50),
        PlayerSkin(name: "Pizza", imageName: "jumpPizza", requiredScore: 55),
        PlayerSkin(name: "Big Blue", imageName: "jumpBlue", requiredScore: 60),
        PlayerSkin(name: "Lombric Kid", imageName: "jumpKarateKid", requiredScore: 65),
        PlayerSkin(name: "GoofyBot", imageName: "jumpRobot", requiredScore: 70),
        PlayerSkin(name: "Waly", imageName: "jumpEve", requiredScore: 70),
        PlayerSkin(name: "Sticky", imageName: "jumpStickman", requiredScore: 70),
        PlayerSkin(name: "Fanta Claus", imageName: "jumpSanta", requiredScore: 70),
        PlayerSkin(name: "Donatello", imageName: "jumpDonatello", requiredScore: 70),
        
        
        
        
        
    ]
    
    var body: some View {
        
        let highScore = gameData?.highScore ?? 0
        
        
        let columns = Array(repeating: GridItem(.flexible(minimum: 100), spacing: 16), count: 5)
        
        VStack {
            Text("Select Player")
                .font(.custom("Invasion2000", size: 40))
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyVGrid(columns: columns) { // HStack(spacing: 20)
                    ForEach(PlayerSkinSelector.skins) { skin in
                        VStack {
                            Image(skin.imageName)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedSkin == skin.imageName ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .opacity(highScore >= skin.requiredScore ? 1 : 0.5)
                                .onTapGesture {
                                    if highScore >= skin.requiredScore {
                                        selectedSkin = skin.imageName
                                    }
                                }
                            
                            Text(skin.name)
                                .font(.custom("Invasion2000", size: 15))
                            
                            if highScore < skin.requiredScore {
                                Text("Unlock at \(skin.requiredScore)")
                                    .font(.custom("Invasion2000", size: 12))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
