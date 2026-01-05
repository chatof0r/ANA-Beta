import SwiftUI

struct OnboardingView: View {
    // MARK: - DONNÉES DU PROFIL
    @State private var firstName: String = ""
    @State private var studyLevel: String = "L1 (Première année)"
    @State private var semesterEndDate: Date = Date()
    
    // Pour fermer l'onboarding quand c'est fini
    @State private var currentStep = 0
    
    let levels = ["L1", "L2", "L3", "Master 1", "Master 2", "PASS/LAS", "Autre"]
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {
        ZStack {
            customBackground.ignoresSafeArea()
            
            TabView(selection: $currentStep) {
                // ÉTAPE 1 : PRÉNOM
                VStack(spacing: 30) {
                    Text("Comment t'appelles-tu ?")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    TextField("Ton prénom", text: $firstName)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white.opacity(0.1)))
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(.white.opacity(0.3), lineWidth: 1))
                        .padding(.horizontal, 40)
                    
                    nextButton(step: 1)
                }
                .tag(0)
                
                // ÉTAPE 2 : NIVEAU D'ÉTUDES
                VStack(spacing: 30) {
                    Text("Quel est ton niveau d'études ?")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Picker("Niveau", selection: $studyLevel) {
                        ForEach(levels, id: \.self) { level in
                            Text(level).tag(level)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    .padding()
                    
                    nextButton(step: 2)
                }
                .tag(1)
                
                // ÉTAPE 3 : FIN DU SEMESTRE
                VStack(spacing: 30) {
                    Text("Quand se termine ton semestre ?")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    DatePicker("", selection: $semesterEndDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .colorScheme(.dark) // Force le calendrier en mode sombre
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(.white.opacity(0.05)))
                        .padding(.horizontal, 20)
                    
                    Button(action: {
                        print("Profil créé : \(firstName), \(studyLevel), \(semesterEndDate)")
                        // Ici tu pourras plus tard enregistrer les données
                    }) {
                        Text("Terminer")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                    }
                    .buttonStyle(GlassButtonStyle())
                    .padding(.horizontal, 40)
                }
                .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always)) // Affiche les petits points en bas
        }
    }
    
    // Fonction pour le bouton suivant
    func nextButton(step: Int) -> some View {
        Button(action: {
            withAnimation {
                currentStep = step
            }
        }) {
            Text("Suivant")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
        }
        .buttonStyle(GlassButtonStyle())
        .padding(.horizontal, 40)
        .disabled(step == 1 && firstName.isEmpty) // Désactive si le prénom est vide
        .opacity(step == 1 && firstName.isEmpty ? 0.5 : 1)
    }
}

#Preview {
    OnboardingView()
}