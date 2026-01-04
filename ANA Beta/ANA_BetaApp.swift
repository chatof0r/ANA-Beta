import SwiftUI
import SwiftData

@main
struct ANA_BetaApp: App {
    // On crée le moteur ici pour toute l'application
    @StateObject var cardManager = CardManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cardManager) // On injecte le moteur ici
        }
    }
}
