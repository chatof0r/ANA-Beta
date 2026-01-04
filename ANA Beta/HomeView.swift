import SwiftUI

// MARK: - 1. STYLE DE BOUTON
struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(
                RoundedRectangle(cornerRadius: 20) // J'ai remis 20 pour le look carré arrondi
                    .fill(.white.opacity(0.1))
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                    .blur(radius: 0.5)
            )
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - 2. VUE ACCUEIL
struct HomeView: View {
    // AJOUT : On récupère le moteur de cartes partagé
    @EnvironmentObject var cardManager: CardManager
    
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                customBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        
                        // --- SECTION EN-TÊTE ---
                        VStack(alignment: .leading, spacing: 20) {
                            Spacer().frame(height: 20)
                            Text("Bonjour Arthur")
                                .font(.largeTitle.weight(.bold))
                                .foregroundColor(.white)
                            Divider().background(.white)
                        }
                        
                        // --- BOUTON : FLASHCARDS DU JOUR ---
                        // On crée un bouton qui affiche le nombre de cartes
                        Button(action: {
                            print("Lancement des \(cardManager.getReviewSession().count) cartes")
                        }) {
                            HStack(spacing: 15) {
                                Image(systemName: "bolt.fill")
                                Text("Flashcards (\(cardManager.getReviewSession().count))")
                                    .font(.title2.weight(.bold))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                        }
                        .buttonStyle(GlassButtonStyle())
                        
                        // --- BOUTON : THE SPINE ---
                        // Note: On utilise Text temporairement pour éviter l'erreur si TheSpine() n'est pas prêt
                        NavigationLink(destination: Text("Page The Spine en cours...")) {
                            HStack(spacing: 15) {
                                Image(systemName: "square.grid.2x2.fill")
                                Text("The Spine")
                                    .font(.title2.weight(.bold))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                        }
                        .buttonStyle(GlassButtonStyle())
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
            }
        }
    }
}

// MARK: - 3. PRÉVISUALISATION
#Preview {
    // IMPORTANT : On injecte un manager de test pour que la preview ne crash pas
    HomeView()
        .environmentObject(CardManager())
}
