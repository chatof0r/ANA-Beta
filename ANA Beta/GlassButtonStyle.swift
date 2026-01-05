//
//  GlassButtonStyle.swift
//  ANA Beta
//
//  Created by Arthur Roche on 05/01/2026.
//


import SwiftUI

// Un seul endroit pour gérer le look de tes boutons
struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.clear) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(configuration.isPressed ? 0.4 : 0.15), lineWidth: 1.2)
                    )
            )
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(configuration.isPressed ? .white.opacity(0.05) : .clear)
            )
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}