import SwiftUI

// MARK: - GESTIONNAIRE D'ONGLETS
struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // On appelle simplement les structures des autres fichiers
            HomeView()
                .tabItem {
                    Label("Accueil", systemImage: "house.fill")
                }
                .tag(0)
            
            LibraryView()
                .tabItem {
                    Label("Librairie", systemImage: "books.vertical.fill")
                }
                .tag(1)
        }
        .tint(.white) // Couleur de l'onglet actif
    }
}
#Preview {
    ContentView()
}
