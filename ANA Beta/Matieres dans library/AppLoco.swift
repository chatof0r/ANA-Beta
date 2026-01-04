//
//  Module1.swift
//  ANA Beta
//
//  Created by Arthur Roche on 03/01/2026.
//
import SwiftUI
struct AppLoco: View {
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {
        ZStack {
            customBackground.ignoresSafeArea()
            
            Text("Bienvenue dans le Module 1")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
        // Pour que le bouton "Retour" soit blanc
        .navigationBarTitleDisplayMode(.inline)
    }
}
