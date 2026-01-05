import SwiftUI // Importation du framework d'interface

// MARK: - GESTIONNAIRE D'ONGLETS
struct ContentView: View { // Définition de la structure principale de navigation
    @State private var selectedTab = 0 // Variable d'état pour suivre l'onglet actif
    
    var body: some View { // Définition du corps de la vue
        TabView(selection: $selectedTab) { // Création de la barre d'onglets liée à l'état
            
            // On appelle simplement les structures des autres fichiers
            HomeView() // Appel de la vue d'accueil
                .tabItem { // Définition de l'apparence de l'onglet
                    Label("Accueil", systemImage: "house.fill") // Texte et icône système
                } // Fin de configuration tabItem
                .tag(0) // Identifiant unique pour le premier onglet
            
            LibraryView() // Appel de la vue librairie
                .tabItem { // Définition de l'apparence de l'onglet
                    Label("Librairie", systemImage: "books.vertical.fill") // Texte et icône système
                } // Fin de configuration tabItem
                .tag(1) // Identifiant unique pour le second onglet
        } // Fin de la TabView
        .tint(.white) // Couleur des éléments actifs dans la barre
    } // Fin du body
} // Fin de la structure

#Preview { // Bloc de rendu pour l'aperçu Xcode
    ContentView() // Instanciation de la vue pour le canva
} // Fin du preview
