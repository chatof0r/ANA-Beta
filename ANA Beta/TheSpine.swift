//
//  Module1.swift
//  ANA Beta
//
//  Created by Arthur Roche on 03/01/2026.
//
import SwiftUI
struct TheSpine: View {
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {
        ZStack {
            customBackground.ignoresSafeArea() // Fond identique
            
            VStack {
                Text("The Spine") // Titre de la page
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Text("Détails de la colonne vertébrale") // Sous-titre
                    .foregroundColor(.gray)
            }
        }
    }
}

