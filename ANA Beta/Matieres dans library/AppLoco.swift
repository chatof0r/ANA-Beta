import SwiftUI // Importation du framework SwiftUI pour construire l'interface

// MARK: - VUE APPAREIL LOCOMOTEUR
struct AppLoco: View { // Déclaration d'une vue SwiftUI nommée AppLoco
    @Environment(\.dismiss) var dismiss // Permet de fermer la vue pour revenir en arrière
    
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255) // Définition d'une couleur de fond personnalisée
    
    var body: some View { // Corps de la vue : décrit l'interface à afficher
        ZStack { // Empile les vues : les éléments ajoutés ensuite se superposent aux précédents
            customBackground.ignoresSafeArea() // Applique le fond sur toute la surface de l'écran
            
            VStack(spacing: 20) { // Organise le texte et le bouton verticalement avec 30px d'écart
                
                Text("Cours à venir") // Contenu du texte
                    .font(.title3.weight(.medium)) // Style de texte
                    .foregroundColor(.white) // Couleur de texte
                    .multilineTextAlignment(.center) // Alignement au centre
                    .tracking(1.2) // Ajuste l'espace entre les mots/lettres
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
                } // Fin du bouton
                
            } // Fin de la VStack
        } // Fin du ZStack
        .navigationBarBackButtonHidden(true) // Cache le bouton retour standard d'iOS
    }
}

// MARK: - PRÉVISUALISATION
#Preview { // Commande pour activer la visualisation
    AppLoco() // Page que le canva doit afficher
}
