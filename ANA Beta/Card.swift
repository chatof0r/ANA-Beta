//
//  Card.swift
//  ANA Beta
//
//  Created by Arthur Roche on 04/01/2026.
//


import Foundation

struct Card: Identifiable, Codable {
    var id = UUID()
    
    // --- CONTENU ---
    var question: String
    var answer: String
    
    // --- CLASSEMENT (Tes balises) ---
    var subject: String // Ex: "Pneumo", "Cardio"
    var chapter: String // Ex: "Anatomie", "Myologie"
    
    // --- SESSION ACTUELLE (Logique du jour) ---
    // Compte combien de fois l'étudiant l'a mise à gauche (Non su) aujourd'hui
    var dailyErrorCount: Int = 0 
    
    // --- ALGORITHME SRS (Pour plus tard) ---
    var lastReviewDate: Date? // Dernière fois qu'elle a été vue
    var nextReviewDate: Date = Date() // Quand doit-elle revenir ? (Par défaut : maintenant)
    var interval: Int = 0 // Espace en jours entre deux révisions
    var easeFactor: Double = 2.5 // Facteur de facilité (Standard SM-2)
}