import Foundation
import SwiftUI



struct UnlockAnimationView: View {
    let skin: PlayerSkin
    var onDismiss: () -> Void
    
    @State private var scale: CGFloat = 0.1
    @State private var opacity: Double = 0
    @State private var isShowing = true
    
    var body: some View {
        VStack {
            if isShowing {
                VStack(spacing: 10) {
                    Text("New Skin!")
                        .font(.custom("Invasion2000", size: 16))
                        .foregroundColor(.white)
                    
                    Image(skin.imageName)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    
                    Text(skin.name)
                        .font(.custom("Invasion2000", size: 14))
                        .foregroundColor(.white)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.black.opacity(0.8))
                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 15)
//                        .stroke(Color.white, lineWidth: 2)
//                )
                .scaleEffect(scale)
                .opacity(opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .onAppear {
            withAnimation(.spring()) {
                scale = 1
                opacity = 1
            }
            
            // Disparaît automatiquement après 3 secondes
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 0.5)) {
                    scale = 0.5
                    opacity = 0
                    isShowing = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    onDismiss()
                }
            }
        }
    }
}
