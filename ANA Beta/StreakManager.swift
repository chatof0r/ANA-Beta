import SwiftUI
import Combine

/// Manager gérant la persistance des flammes et des jours complétés.
class StreakManager: ObservableObject {
    
    // On utilise @Published pour que SwiftUI rafraîchisse la vue lors d'un changement
    @Published var streakCount: Int = UserDefaults.standard.integer(forKey: "streakCount")
    @Published var lastCompletionDate: String = UserDefaults.standard.string(forKey: "lastCompletionDate") ?? ""
    @Published var completedDaysData: String = UserDefaults.standard.string(forKey: "completedDays") ?? ""

    /// Set calculé pour une recherche ultra-rapide des jours complétés (O(1))
    var completedDays: Set<String> {
        Set(completedDaysData.components(separatedBy: ",").filter { !$0.isEmpty })
    }

    /// Fonction pour valider la session de flashcards du jour
    func validateDailyFlashcards() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        
        // 1. Mise à jour de la liste des jours complétés
        var days = completedDays
        if !days.contains(today) {
            days.insert(today)
            let updatedData = days.joined(separator: ",")
            
            // Sauvegarde locale
            completedDaysData = updatedData
            UserDefaults.standard.set(updatedData, forKey: "completedDays")
            
            // 2. Logique de calcul du Streak (Flammes)
            if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
                let yesterdayString = formatter.string(from: yesterday)
                
                if lastCompletionDate == yesterdayString {
                    // Succès consécutif : +1 flamme
                    streakCount += 1
                } else if lastCompletionDate != today {
                    // Rupture de streak ou premier jour : reset à 1
                    streakCount = 1
                }
            } else {
                streakCount = 1
            }
            
            // 3. Persistance des données de streak
            lastCompletionDate = today
            UserDefaults.standard.set(streakCount, forKey: "streakCount")
            UserDefaults.standard.set(today, forKey: "lastCompletionDate")
            
            // On force la notification de mise à jour pour les vues
            objectWillChange.send()
        }
    }
}
