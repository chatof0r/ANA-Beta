import SwiftUI

// MARK: - VUE LIBRAIRIE
struct LibraryView: View {
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                customBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) { // Espacement entre les modules
                        // --- SECTION EN-TÊTE ---
                        VStack(alignment: .leading, spacing: 20) {// Espace
                            Spacer().frame(height: 80)
                        }
                        
                        // --- MODULE 2 : CARDIO ---
                        NavigationLink(destination: AppCardio()) {
                            Text("🫀 Appareil Cardio")
                                .font(.title.weight(.bold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 120)
                        }
                        .buttonStyle(GlassButtonStyle())
            
                        // --- MODULE 3 : RESPIRATOIRE ---
                        NavigationLink(destination: AppRespi()) {
                            Text("🫁 Appareil Respiratoire")
                                .font(.title.weight(.bold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 120)
                        }
                        .buttonStyle(GlassButtonStyle())
                        
                        // --- MODULE ACTIF : LOCOMOTEUR ---
                        NavigationLink(destination: AppLoco()) {
                            Text("🦴 Appareil Locomoteur")
                                .font(.title.weight(.bold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 150)
                        }
                        .buttonStyle(GlassButtonStyle())
                        
                        // --- BOUTON INACTIF : D1 ---
                        Button(action: {
                        }) {
                            Text("D1")
                                .font(.title.weight(.bold))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white.opacity(0.4))
                                .frame(height: 120)
                        }
                        .buttonStyle(GlassButtonStyle()) // animation de clic 
                        // --- BOUTON INACTIF : P1 ---
                        Button(action: {
                            // On ne met rien ici
                        }) {
                            Text("P1")
                                .font(.title.weight(.bold))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white.opacity(0.4))
                                .frame(height: 120)
                        }
                        .buttonStyle(GlassButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                }
            }
        }
    }
}

#Preview {
    LibraryView()
}
