import SwiftUI

@main
struct ANA_BetaApp: App {
    // Cette variable surveille si l'utilisateur a fini son profil
    // Elle est sauvegardée sur le téléphone sous le nom "hasCompletedOnboarding"
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                // Si le profil est créé, on va directement à l'accueil
                ContentView()
            } else {
                // Sinon, on affiche la page de création de profil
                OnboardingView()
            }
        }
    }
}
