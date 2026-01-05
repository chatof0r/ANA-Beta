//
//  FlashcardsSuccessView.swift
//  ANA Beta
//
//  Created by Arthur Roche on 05/01/2026.
//


import SwiftUI

struct FlashcardsSuccessView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var streakManager = StreakManager()
    @State private var animateConfetti = false

    var body: some View {
        ZStack {
            Color(red: 22/255, green: 21/255, blue: 29/255).ignoresSafeArea()
            
            // Effet de confettis ultra simple
            ForEach(0..<15) { i in
                Text("🎉")
                    .font(.title)
                    .offset(x: animateConfetti ? CGFloat.random(in: -150...150) : 0,
                            y: animateConfetti ? CGFloat.random(in: -300...300) : 0)
                    .opacity(animateConfetti ? 0 : 1)
                    .animation(.easeOut(duration: 1.5).delay(Double(i) * 0.05), value: animateConfetti)
            }

            VStack(spacing: 30) {
                Text("Félicitations !")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text("Tu as terminé tes flashcards du jour.")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button(action: {
                    streakManager.validateDailyFlashcards()
                    dismiss()
                }) {
                    Text("Valider ma journée")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 100/255, green: 210/255, blue: 115/255))
                        .cornerRadius(15)
                }
                .padding(.horizontal, 40)
            }
        }
        .onAppear { animateConfetti = true }
    }
}

#Preview {
    FlashcardsSuccessView()
}
