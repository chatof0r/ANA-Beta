import SwiftUI

struct HomeView: View {
    // Stockage utilisateur
    @AppStorage("userFirstName") var userFirstName: String = "Arthur"
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @AppStorage("studyLevel") var userstudyLevel: String = "P1/L1"
    
    // États pour la discussion avec Ana
    @State private var chatInput: String = ""
    @State private var isChatOpen: Bool = false
    
    // Couleur personnalisée
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    // Calcul dynamique du compte à rebours examens
    var examStatus: (days: String, subtitle: String) {
        let now = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: now)
        let month = calendar.component(.month, from: now)
        let year = calendar.component(.year, from: now)
        
        let isWinterVac = (month == 12 && day >= 24) || (month == 1 && day <= 2)
        let isSummerVac = (month >= 7 && month <= 8)
        
        if isWinterVac || isSummerVac { return ("REPOS", "vacances") }
        
        var targetDate: Date
        if month >= 9 && month <= 12 {
            switch userstudyLevel {
            case "P1/L1": targetDate = calendar.date(from: DateComponents(year: year, month: 12, day: 9))!
            case "P2":    targetDate = calendar.date(from: DateComponents(year: year, month: 12, day: 15))!
            case "D1":    targetDate = calendar.date(from: DateComponents(year: year, month: 12, day: 12))!
            default:      targetDate = Date()
            }
        } else {
            switch userstudyLevel {
            case "P1/L1": targetDate = calendar.date(from: DateComponents(year: year, month: 4, day: 9))!
            case "P2":    targetDate = calendar.date(from: DateComponents(year: year, month: 5, day: 5))!
            case "D1":    targetDate = calendar.date(from: DateComponents(year: year, month: 5, day: 4))!
            default:      targetDate = Date()
            }
        }
        
        if now > targetDate {
            return ("0", "en cours")
        } else {
            let diff = calendar.dateComponents([.day], from: now, to: targetDate)
            return ("\(diff.day ?? 0)", "restants")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                customBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        headerSection
                        
                        // --- CARTE ACTIVITÉ (CALENDRIER) ---
                        // ActivityCard()
                        
                        anaSection
                        
                        resetButtonSection
                    }
                    .padding(.horizontal, 20)
                }
            }
            .sheet(isPresented: $isChatOpen) {
                ChatModalView(initialMessage: chatInput)
                    .presentationDetents([.fraction(0.85), .large])
                    .presentationDragIndicator(.visible)
                    .presentationBackground(.ultraThinMaterial)
            }
        }
    }

    // MARK: - Sous-Vues HomeView
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer().frame(height: 15)
            
            Text("Bonjour \(userFirstName),")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(.white)
            
            HStack(alignment: .center, spacing: 5) {
                dateBlock
                cardsBlock
                counterBlock
            }
            .environment(\.locale, Locale(identifier: "fr_FR"))
            
            Divider().background(.white.opacity(0.3))
        }
    }

    private var dateBlock: some View {
        HStack(spacing: 8) {
            Image(systemName: "calendar").foregroundColor(.red)
            VStack(alignment: .leading, spacing: -2) {
                Text(Date(), format: .dateTime.day().month())
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .textCase(.uppercase)
                Text(Date(), format: .dateTime.weekday(.wide))
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var cardsBlock: some View {
        HStack(spacing: 8) {
            Image(systemName: "rectangle.stack.fill").foregroundColor(.blue)
            VStack(alignment: .leading, spacing: -2) {
                Text("22 Cartes")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("Aujourd'hui")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private var counterBlock: some View {
        HStack(spacing: 6) {
            Image(systemName: "hourglass").foregroundColor(.orange)
            VStack(alignment: .leading, spacing: -2) {
                Text(examStatus.days == "REPOS" ? "REPOS" : "\(examStatus.days) Jours")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                Text(examStatus.subtitle)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    private var anaSection: some View {
        VStack(spacing: 15) {
            HStack(spacing: 4) {
                Text("Demandez à").font(.title3.bold()).foregroundColor(.white)
                Text("Ana").font(.title3.bold()).foregroundColor(.blue)
            }
            
            HStack {
                TextField("", text: $chatInput, prompt:
                    Text("Salut Ana, cite tous les os du nez")
                    .foregroundColor(.white.opacity(0.3))
                )
                .padding(.leading, 15)
                .foregroundColor(.white)
                .tint(.blue)
                
                if chatInput.count >= 3 {
                    Button(action: { isChatOpen = true }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .shadow(color: .white.opacity(0.8), radius: 8)
                    }
                    .padding(.trailing, 8)
                }
            }
            .frame(height: 58)
            .background(RoundedRectangle(cornerRadius: 22).fill(Color.white.opacity(0.08)))
            .overlay(RoundedRectangle(cornerRadius: 22).stroke(Color.white.opacity(0.15), lineWidth: 1))
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 28).fill(Color.white.opacity(0.03)))
        .overlay(RoundedRectangle(cornerRadius: 28).stroke(Color.white.opacity(0.1), lineWidth: 1))
    }

    private var resetButtonSection: some View {
        Button(action: { hasCompletedOnboarding = false }) {
            Text("Réinitialiser l'App (Test)")
                .font(.caption)
                .foregroundColor(.red.opacity(0.4))
        }
        .padding(.top, 50)
    }
}

// --- VUE DE L'ONGLET DE CHAT ---
struct ChatModalView: View {
    var initialMessage: String
    @Environment(\.dismiss) var dismiss
    // Remplace @State par @StateObject
    @State private var aiManager = AIManager()
    var body: some View {
        VStack(spacing: 20) {
            headerView
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    userBubble
                    anaResponseBubble
                }
                .padding()
            }
        }
        .onAppear {
            Task {
                await aiManager.generateResponse(userInput: initialMessage)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Discussion avec \(Text("Ana").foregroundColor(.blue).bold())")
        }
        .font(.headline)
        .padding(.top, 25)
    }
    
    private var userBubble: some View {
        HStack {
            Spacer()
            Text(initialMessage)
                .padding()
                .background(Color.blue.opacity(0.15))
                .cornerRadius(30)
                .foregroundColor(.white)
        }
    }
    
    private var anaResponseBubble: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "sparkles").foregroundColor(.blue)
                Text("Ana").font(.caption.bold()).foregroundColor(.blue)
            }
            
            if aiManager.isThinking {
                ProgressView().tint(.blue).padding(.leading, 5)
            } else {
                Text(aiManager.responseText)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(30)
    }
}

// --- PREVIEWS ---
#Preview("Accueil") {
    HomeView()
}
