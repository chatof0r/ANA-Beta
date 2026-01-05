import SwiftUI

/// Composant de tableau de bord affichant l'activité utilisateur et la progression temporelle du semestre.
struct ActivityCard: View {
    // Stockage persistant du niveau d'étude pour ajuster dynamiquement les dates de fin de semestre
    @AppStorage("studyLevel") var userstudyLevel: String = "P1/L1"
    
    // Définition de la palette de couleurs pour le rendu de l'activité (Vert succès / Gris neutre)
    let activeColor = Color(red: 100/255, green: 210/255, blue: 115/255)
    let inactiveColor = Color.white.opacity(0.1)
    let emptyColor = Color.clear // Utilisé pour le padding visuel des jours hors mois courant
    
    // Propriété calculée générant une matrice 2D représentant les jours du mois actuel
    var calendarDays: [[Int]] {
        let calendar = Calendar.current // Instance du calendrier système
        let now = Date() // Date actuelle (Date pivot)
        
        // Récupération de l'étendue des jours (ex: 1 à 31) et de l'objet Date du premier jour du mois
        guard let range = calendar.range(of: .day, in: .month, for: now),
              let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now)) else { return [] }
        
        let numberOfDays = range.count // Nombre total de jours dans le mois en cours
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth) // Jour de la semaine du 1er du mois
        let offset = (firstWeekday + 5) % 7 // Normalisation pour que Lundi = index 0
        
        var weeks: [[Int]] = [] // Conteneur pour la structure en lignes (semaines)
        var currentDay = 1 // Curseur d'itération des jours réels
        
        for _ in 0..<6 { // Itération sur les 6 lignes potentielles d'un calendrier mensuel
            var week: [Int] = [] // Initialisation d'une ligne de semaine
            for column in 0..<7 { // Itération sur les 7 colonnes (Lundi à Dimanche)
                let dayIndex = weeks.count * 7 + column // Index global dans la grille 7x6
                if dayIndex < offset || currentDay > numberOfDays {
                    week.append(-1) // Insertion d'une valeur sentinelle pour les cases vides
                } else {
                    week.append(currentDay) // Insertion du jour réel
                    currentDay += 1 // Incrémentation du jour
                }
            }
            weeks.append(week) // Ajout de la semaine à la matrice
            if currentDay > numberOfDays { break } // Sortie précoce si le mois est complété
        }
        return weeks // Retourne la structure de données pour la vue
    }

    // Propriété calculée déterminant le ratio d'avancement du semestre en cours (0.0 à 1.0)
    var semesterProgress: Double {
        let now = Date() // Date de l'instant T
        let calendar = Calendar.current // Référence calendaire
        let year = calendar.component(.year, from: now) // Année en cours
        let month = calendar.component(.month, from: now) // Mois en cours
        var startDate: Date // Borne inférieure du calcul
        var endDate: Date // Borne supérieure du calcul
        
        // Logique de segmentation saisonnière (Semestre 1 vs Semestre 2)
        if month >= 9 || month == 12 { // Cas du premier semestre (Septembre à Décembre)
            startDate = calendar.date(from: DateComponents(year: year, month: 9, day: 1))!
            switch userstudyLevel { // Adaptation des dates de partiels selon le niveau
            case "P1/L1": endDate = calendar.date(from: DateComponents(year: year, month: 12, day: 9))!
            case "P2":    endDate = calendar.date(from: DateComponents(year: year, month: 12, day: 15))!
            case "D1":    endDate = calendar.date(from: DateComponents(year: year, month: 12, day: 16))!
            default:      endDate = calendar.date(from: DateComponents(year: year, month: 12, day: 15))!
            }
        } else { // Cas du second semestre (Janvier à Mai)
            let startMonth = userstudyLevel == "P2" ? 2 : 1 // Exception réglementaire : les P2 commencent en Février
            startDate = calendar.date(from: DateComponents(year: year, month: startMonth, day: 1))!
            switch userstudyLevel {
            case "P1/L1": endDate = calendar.date(from: DateComponents(year: year, month: 4, day: 9))!
            case "P2":    endDate = calendar.date(from: DateComponents(year: year, month: 5, day: 5))!
            case "D1":    endDate = calendar.date(from: DateComponents(year: year, month: 5, day: 4))!
            default:      endDate = calendar.date(from: DateComponents(year: year, month: 5, day: 5))!
            }
        }
        
        let totalDuration = endDate.timeIntervalSince(startDate) // Durée totale en secondes
        let elapsed = now.timeIntervalSince(startDate) // Temps écoulé en secondes
        return max(0, min(1.0, elapsed / totalDuration)) // Retourne le ratio normalisé entre 0 et 1
    }

    var body: some View {
        HStack(alignment: .center, spacing: 0) { // Conteneur horizontal principal
            
            // --- SECTION GAUCHE : INDICATEURS DE PERFORMANCE ---
            VStack(alignment: .leading, spacing: 12) {
                // Header : Titre de section et indicateur de "Streak" (Flammes)
                HStack(spacing: 8) {
                    Text("Activité")
                        .font(.headline) // Typographie sémantique pour le titre
                        .foregroundColor(.white.opacity(0.7)) // Atténuation visuelle du label
                    
                    HStack(spacing: 4) { // Groupe visuel pour le compteur de jours
                        Text("3") // Donnée dynamique (à lier ultérieurement)
                            .font(.subheadline.bold())
                        Image(systemName: "flame.fill") // Symbole SF Pro pour la gamification
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.orange) // Couleur d'accentuation pour l'engagement
                }
                
                // Bloc principal : Affichage du pourcentage d'avancement
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(Int(semesterProgress * 100))%") // Conversion du ratio en entier textuel
                        .font(.system(size: 32, weight: .bold, design: .rounded)) // Police pro épurée
                        .foregroundColor(.white)
                    Text("du semestre")
                        .font(.caption) // Label secondaire petit
                        .foregroundColor(.white.opacity(0.5))
                }
                
                // Composant Barre de Progression personnalisée
                GeometryReader { geo in // Utilisation de GeometryReader pour un calcul de largeur adaptatif
                    ZStack(alignment: .leading) {
                        Capsule() // Fond de la barre (track)
                            .fill(Color.white.opacity(0.1))
                        Capsule() // Remplissage dynamique (progress)
                            .fill(activeColor)
                            .frame(width: geo.size.width * CGFloat(semesterProgress)) // Largeur proportionnelle au progrès
                    }
                }
                .frame(height: 8) // Épaisseur augmentant la lisibilité sur mobile
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Occupe l'espace disponible à gauche
            
            Spacer(minLength: 20) // Séparateur flexible entre les deux zones de données
            
            // --- SECTION DROITE : VISUALISATION CALENDAIRE (STYLE GITHUB) ---
            VStack(spacing: 5) { // Empilement vertical des semaines
                ForEach(0..<calendarDays.count, id: \.self) { weekIndex in
                    HStack(spacing: 5) { // Alignement horizontal des jours
                        ForEach(0..<7, id: \.self) { dayIndex in
                            let dayValue = calendarDays[weekIndex][dayIndex] // Récupération de la valeur du jour
                            RoundedRectangle(cornerRadius: 3) // Forme géométrique pour chaque unité de jour
                                .fill(dayValue == -1 ? emptyColor : (dayValue <= 5 ? activeColor : inactiveColor)) // Logique de coloration
                                .frame(width: 16, height: 11) // Dimensions fixes pour la grille
                        }
                    }
                }
            }
            .padding(.trailing, 5) // Ajustement optique de la marge droite
        }
        .padding(22) // Espacement interne global de la carte
        .background(
            RoundedRectangle(cornerRadius: 25) // Arrière-plan stylisé
                .fill(Color.white.opacity(0.05)) // Effet de transparence faible
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25) // Bordure fine pour l'effet "Glassmorphism"
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
    }
}

// Configuration de la prévisualisation pour l'environnement de développement Xcode
#Preview {
    ZStack {
        // Simulation de l'arrière-plan de l'application
        Color(red: 22/255, green: 21/255, blue: 29/255).ignoresSafeArea()
        ActivityCard()
            .padding() // Marges externes pour la prévisualisation
    }
}
