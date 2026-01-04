//
//  FlashcardView.swift
//  ANA Beta
//
//  Created by Arthur Roche on 04/01/2026.
//


import SwiftUI

struct FlashcardView: View {
    let card: Card
    @State private var isFlipped: Bool = false // État pour savoir quel côté afficher
    
    var body: some View {
        ZStack {
            // FACE RECTO (Question)
            CardFace(text: card.question, title: "Question", isFlipped: isFlipped)
                .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped ? 0 : 1)
            
            // FACE VERSO (Réponse)
            CardFace(text: card.answer, title: "Réponse", isFlipped: isFlipped)
                .rotation3DEffect(.degrees(isFlipped ? 0 : -180), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped ? 1 : 0)
        }
        .onTapGesture {
            // Animation de retournement
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                isFlipped.toggle()
            }
        }
    }
}

// Composant pour le design visuel d'une face de la carte
struct CardFace: View {
    let text: String
    let title: String
    let isFlipped: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title.uppercased())
                .font(.caption.weight(.bold))
                .foregroundColor(.white.opacity(0.5))
            
            Spacer()
            
            Text(text)
                .font(.title2.weight(.medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .frame(width: 320, height: 450)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white.opacity(0.1))
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
        )
        .background(.ultraThinMaterial) // Effet de flou derrière le verre
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
}

#Preview {
    ZStack {
        Color(red: 22/255, green: 21/255, blue: 29/255).ignoresSafeArea()
        FlashcardView(card: Card(question: "Exemple de question ?", answer: "Exemple de réponse", subject: "Test", chapter: "Test"))
    }
}
