import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @AppStorage("userFirstName") var userFirstName: String = ""
    
    @State private var firstName: String = ""
    @State private var studyLevel: String = ""
    @State private var showLevelPicker = false
    
    let levels = ["P1/L1", "P2", "D1"]
    let customBackground = Color(red: 22/255, green: 21/255, blue: 29/255)
    
    var body: some View {
        ZStack {
            customBackground.ignoresSafeArea()
            
            VStack(spacing: 60) {
                Spacer()
                
                // --- SECTION 1 : PRÉNOM ---
                ZStack(alignment: .trailing) {
                    TextField("", text: Binding(
                        get: { self.firstName },
                        set: { newValue in
                            if let first = newValue.first {
                                self.firstName = first.uppercased() + newValue.dropFirst()
                            } else {
                                self.firstName = newValue
                            }
                        }
                    ), prompt: Text("Ton prénom").foregroundColor(.white.opacity(0.3)))
                    .padding(.leading, 25)
                    .padding(.trailing, 60)
                    .frame(height: 70)
                    .background(RoundedRectangle(cornerRadius: 35).fill(Color.white.opacity(0.05)))
                    .overlay(RoundedRectangle(cornerRadius: 35).stroke(Color.white.opacity(0.2), lineWidth: 1))
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .tint(.white)
                    
                    Button(action: {
                        if firstName.count >= 3 {
                            hideKeyboard()
                            withAnimation(.spring()) {
                                showLevelPicker = true
                            }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(firstName.count >= 3 ? Color.white : Color.gray.opacity(0.2))
                                .frame(width: 45, height: 45)
                                .shadow(color: .white.opacity(firstName.count >= 3 ? 0.5 : 0), radius: 10)
                            
                            Image(systemName: "arrow.down")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(firstName.count >= 3 ? customBackground : .gray.opacity(0.5))
                        }
                    }
                    .padding(.trailing, 12)
                    .disabled(firstName.count < 3 || showLevelPicker)
                    .opacity(showLevelPicker ? 0 : 1)
                }
                .padding(.horizontal, 30)
                
                // --- SECTION 2 : NIVEAU ---
                if showLevelPicker {
                    VStack(spacing: 10) {
                        Text("En quelle année es-tu ?")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Picker("Niveau", selection: $studyLevel) {
                            if studyLevel.isEmpty {
                                Text("Sélectionne ton année").tag("")
                            }
                            ForEach(levels, id: \.self) { level in
                                Text(level).tag(level)
                            }
                        }
                        .pickerStyle(.wheel)
                        .colorScheme(.dark)
                        .frame(height: 120)
                        
                        Button(action: {
                            if !studyLevel.isEmpty {
                                self.userFirstName = self.firstName
                                withAnimation(.spring()) {
                                    hasCompletedOnboarding = true
                                }
                            }
                        }) {
                            Text("Commencer")
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 150, height: 50)
                                .background(studyLevel.isEmpty ? Color.gray.opacity(0.2) : Color.white)
                                .foregroundColor(studyLevel.isEmpty ? .gray : customBackground)
                                .cornerRadius(25)
                                .shadow(color: .white.opacity(studyLevel.isEmpty ? 0 : 0.4), radius: 10)
                        }
                        .disabled(studyLevel.isEmpty)
                        .padding(.top, 10)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                Spacer()
                Spacer()
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    OnboardingView()
}
