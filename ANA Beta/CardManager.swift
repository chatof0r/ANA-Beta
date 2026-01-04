import SwiftUI
import Combine // <--- AJOUTE CETTE LIGNE

class CardManager: ObservableObject {
    // La liste complète de toutes tes cartes
    @Published var allCards: [Card] = []
    
    init() {
        loadSampleData() // Charge les fausses cartes au démarrage
    }
    
    // --- 1. FONCTIONS DE FILTRAGE ---
    
    // Récupère les cartes à réviser (Date dépassée OU jamais vue)
    func getReviewSession() -> [Card] {
        return allCards.filter { $0.nextReviewDate <= Date() }
    }
    
    // Récupère les cartes d'une Matière spécifique (ex: Cardio)
    func getCards(forSubject subject: String) -> [Card] {
        return allCards.filter { $0.subject == subject }
    }
    
    // --- 2. DONNÉES DE TEST ---
    func loadSampleData() {
        allCards = [
            Card(question: "Quel vaisseau transporte le sang oxygéné ?",
                 answer: "L'Aorte",
                 subject: "Cardio",
                 chapter: "Vaisseaux"),
            
            Card(question: "Quel muscle principal assure la ventilation ?",
                 answer: "Le Diaphragme",
                 subject: "Pneumo",
                 chapter: "Myologie")
        ]
    }
}
