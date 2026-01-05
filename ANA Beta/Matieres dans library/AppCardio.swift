import SwiftUI

// MARK: - VUE APPAREIL Cardio
struct AppCardio: View {
    // Environnement pour permettre au bouton de fermer la page
    @Environment(\.dismiss) var dismiss // Permet de revenir en arrière
    
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255) // Couleur de fond ANA
    
    var body: some View {
        ZStack {
            customBackground.ignoresSafeArea() // Fond sur tout l'écran
            
            VStack(spacing: 20) { // Colonne avec espacement large
                
                // --- ICONE ---
                Text("🫀") // Emoji poumons
                    .font(.system(size: 80)) // Taille de l'icône
                
                // --- TEXTE CENTRAL ---
                Text("Cette partie n’est pas\nencore codée, son dev à\npréféré dormir ou sortir") // Contenu du texte
                    .font(.title3.weight(.medium)) // Style de texte
                    .foregroundColor(.white) // Couleur de texte
                    .multilineTextAlignment(.center) // Alignement au centre
                    .tracking(1.2) // ajuste l'espace entre les mots/lettres
                    .lineSpacing(5) // Espace entre les lignes de texte
                
                // --- BOUTON RETOUR ---
                Button(action: {
                    dismiss() // Action : ferme la vue actuelle
                }) {
                    HStack {
                        Image(systemName: "arrow.left") // Icône flèche gauche
                        Text("Retour") // Texte du bouton
                    }
                    .padding(.vertical, 10) // Marge interne haut/bas
                    .padding(.horizontal, 20) // Marge interne gauche/droite
                    .background(Color.white.opacity(0.2)) // Fond gris translucide
                    .foregroundColor(.white) // Texte et icône en blanc
                    .clipShape(Capsule()) // Forme de pilule (bords très arrondis)
                    .overlay(
                        Capsule().stroke(Color.white.opacity(0.3), lineWidth: 1) // Bordure fine
                    )
                }
                
            }
            .padding(40) // Marges sur les côtés de la VStack
        }
        .navigationBarBackButtonHidden(true) // Cache le bouton retour par défaut d'iOS
    }
}

// MARK: - PRÉVISUALISATION
#Preview {
    AppCardio()
}
