import Foundation
import SwiftUI
import GoogleGenerativeAI

@Observable
class AIManager {
    private var model: GenerativeModel?
    var responseText: String = ""
    var isThinking: Bool = false
    
    init() {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist.object(forKey: "API_KEY") as? String else {
            print("❌ Erreur : Fichier plist ou clé API introuvable")
            return
        }

        self.model = GenerativeModel(
            name: "gemini-1.5-flash",
            apiKey: value,
            safetySettings: [
                SafetySetting(harmCategory: .harassment, threshold: .blockOnlyHigh),
                SafetySetting(harmCategory: .hateSpeech, threshold: .blockOnlyHigh),
                SafetySetting(harmCategory: .sexuallyExplicit, threshold: .blockOnlyHigh),
                SafetySetting(harmCategory: .dangerousContent, threshold: .blockOnlyHigh)
            ],
            systemInstruction: "Tu es Ana, une assistante."
        )
    }

    @MainActor
    func generateResponse(userInput: String) async {
        guard let model = model else {
            self.responseText = "Modèle non configuré."
            return
        }
        
        self.isThinking = true
        self.responseText = ""
        
        do {
            // Tentative d'appel direct
            let response = try await model.generateContent(userInput)
            
            // On vérifie si on a du texte
            if let text = response.text {
                self.responseText = text
            } else {
                self.responseText = "L'IA a répondu mais le texte est vide (Filtre de sécurité ?)"
            }
            
        } catch {
            // Affiche l'erreur complète dans la console Xcode
            print("--- ERREUR GEMINI DÉTAILLÉE ---")
            print(error)
            print("-------------------------------")
            
            self.responseText = "Erreur technique : \(error.localizedDescription)"
        }
        
        self.isThinking = false
    }
}
