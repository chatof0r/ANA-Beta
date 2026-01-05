import SwiftUI

// MARK: - 1. VUE ACCUEIL
struct HomeView: View {
    // 1. On récupère le prénom stocké (Arthur est la valeur par défaut si vide)
    @AppStorage("userFirstName") var userFirstName: String = "Arthur"
    
    // 2. On récupère aussi la variable de navigation pour le bouton Reset si besoin
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {

        NavigationStack {
            ZStack {
                customBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        
                        // --- SECTION EN-TÊTE ---
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer().frame(height: 15)
                            
                            Text("Bonjour \(userFirstName),")
                                .font(.largeTitle.weight(.bold))
                                .foregroundColor(.white)
                            
                            // --- SECTION INFOS DATE ---
                            HStack(alignment: .center) {
                                
                                // COLONNE 1 : BLOC DATE
                                HStack(spacing: 8) {
                                    Image(systemName: "calendar")
                                        .font(.system(size: 30))
                                        .foregroundColor(.red)
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(Date(), format: .dateTime.day().month())
                                            .font(.title3.weight(.bold))
                                            .foregroundColor(.white)
                                            .textCase(.uppercase)
                                        
                                        Text(Date(), format: .dateTime.weekday(.wide))
                                            .font(.body)
                                            .foregroundColor(.gray)
                                    }
                                    .environment(\.locale, Locale(identifier: "fr_FR")) 
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // COLONNE 2 & 3 : VIRTUELLES
                                Spacer().frame(maxWidth: .infinity)
                                Spacer().frame(maxWidth: .infinity)
                                
                            } // Fin HStack Date
                            .padding(.vertical, 10)
                            
                            Divider().background(.white)
                            
                        } // Fin En-tête
                        
                        // --- BOUTON : THE SPINE ---
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
                        
                        // --- BOUTON DE TEST : RESET (À SUPPRIMER PLUS TARD) ---
                        Button(action: {
                            UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                        }) {
                            Text("Réinitialiser l'App (Test)")
                                .font(.caption)
                                .foregroundColor(.red.opacity(0.8))
                        }
                        .padding(.top, 450)
                        
                    } // Fin VStack principale
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
                } // Fin ScrollView
            } // Fin ZStack
        } // Fin NavigationStack
    } // Fin Body
}

// MARK: - 2. PRÉVISUALISATION
#Preview {
    HomeView()
}
