//
//  AppCardio.swift
//  ANA Beta
//
//  Created by Arthur Roche on 03/01/2026.
//

import SwiftUI
// MARK: - VUE APPAREIL CARDIO
struct AppCardio: View {
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {
        ZStack {
            customBackground.ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("🫀")
                    .font(.system(size: 80))
                Text("Appareil Cardio")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Text("Contenu des flashcards en cours...")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    AppCardio()
}
