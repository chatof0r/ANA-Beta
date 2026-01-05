import SwiftUI

struct HomeView: View {
    @AppStorage("userFirstName") var userFirstName: String = "Arthur"
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @AppStorage("studyLevel") var userstudyLevel: String = "P1/L1"
    
    // CALCUL DU COMPTEUR (Une seule fois !)
    var examStatus: (days: String, subtitle: String) {
        let now = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: now)
        let month = calendar.component(.month, from: now)
        let year = calendar.component(.year, from: now)
        
        // 1. VACANCES GÉNÉRALES
        let isWinterVac = (month == 12 && day >= 24) || (month == 1 && day <= 2)
        let isSummerVac = (month >= 7 && month <= 8)
        
        if isWinterVac || isSummerVac {
            return ("REPOS", "vacances")
        }
        
        // 2. DÉTERMINATION DE LA CIBLE
        var targetDate: Date
        
        // Si on est entre Septembre et fin Décembre -> Dates du S1
        if month >= 9 && month <= 12 {
            switch userstudyLevel {
            case "P1/L1": targetDate = calendar.date(from: DateComponents(year: year, month: 12, day: 9))!
            case "P2":    targetDate = calendar.date(from: DateComponents(year: year, month: 12, day: 15))!
            case "D1":    targetDate = calendar.date(from: DateComponents(year: year, month: 12, day: 12))!
            default:      targetDate = Date()
            }
        }
        // Si on est entre Janvier et Juin -> Dates du S2
        else {
            switch userstudyLevel {
            case "P1/L1": targetDate = calendar.date(from: DateComponents(year: year, month: 4, day: 9))!
            case "P2":    targetDate = calendar.date(from: DateComponents(year: year, month: 5, day: 5))!
            case "D1":    targetDate = calendar.date(from: DateComponents(year: year, month: 5, day: 4))!
            default:      targetDate = Date()
            }
        }
        
        // 3. LOGIQUE D'AFFICHAGE
        if now > targetDate {
            return ("0", "en cours")
        } else {
            let diff = calendar.dateComponents([.day], from: now, to: targetDate)
            return ("\(diff.day ?? 0)", "restants")
        }
    }
    
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                customBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Spacer().frame(height: 15)
                            
                            Text("Bonjour \(userFirstName),")
                                .font(.largeTitle.weight(.bold))
                                .foregroundColor(.white)
                            
                            HStack(alignment: .center, spacing: 5) {
                                
                                // COLONNE 1 : DATE
                                HStack(spacing: 8) {
                                    Image(systemName: "calendar")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                    
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
                                
                                // COLONNE 2 : CARTES
                                HStack(spacing: 8) {
                                    Image(systemName: "rectangle.stack.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(.blue)
                                    
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
                                
                                // COLONNE 3 : COMPTEUR
                                HStack(spacing: 6) {
                                    Image(systemName: "hourglass")
                                        .font(.system(size: 18))
                                        .foregroundColor(.orange)
                                    
                                    VStack(alignment: .leading, spacing: -2) {
                                        let info = examStatus
                                        Text(info.days == "REPOS" ? "REPOS" : "\(info.days) Jours")
                                            .font(.system(size: 18, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.7)
                                        
                                        Text(info.subtitle)
                                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .environment(\.locale, Locale(identifier: "fr_FR"))
                            .padding(.vertical, 5)
                            
                            Divider().background(.white.opacity(0.3))
                        }
                        
                        NavigationLink(destination: Text("Page The Spine")) {
                            HStack(spacing: 15) {
                                Image(systemName: "square.grid.2x2.fill")
                                Text("The Spine")
                                    .font(.title2.weight(.bold))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                        }
                        .buttonStyle(GlassButtonStyle())
                        
                        Button(action: {
                            UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                        }) {
                            Text("Réinitialiser l'App (Test)")
                                .font(.caption)
                                .foregroundColor(.red.opacity(0.6))
                        }
                        .padding(.top, 100)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}
