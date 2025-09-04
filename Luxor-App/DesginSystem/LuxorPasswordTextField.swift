import SwiftUI

struct PasswordValidation {
    var hasCapitalLetter = false
    var hasMinimumLength = false
    var hasSpecialCharacter = false

    var isValid: Bool {
        hasCapitalLetter && hasMinimumLength && hasSpecialCharacter
    }
}

struct LuxorPasswordTextField: View {
    @Binding var password: String
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var languageManager: LanguageManager
    @State private var isEditing = false
    @State private var isSecure = true
    @State private var validation = PasswordValidation()
    @State private var showValidation = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        themeManager.isDarkMode ?
                        LinearGradient(
                            colors: [
                                LuxorColors.Dark.inputBackground,
                                LuxorColors.Dark.cardBackground
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                        LinearGradient(
                            colors: [
                                LuxorColors.Light.inputBackground,
                                LuxorColors.Light.cardBackground
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(
                                    colors: isEditing ?
                                        themeManager.isDarkMode ?
                                            [LuxorColors.Dark.accent, LuxorColors.Dark.accentSecondary] :
                                            [LuxorColors.Light.accent, LuxorColors.Light.accentSecondary] :
                                        themeManager.isDarkMode ?
                                            [LuxorColors.Dark.border, LuxorColors.Dark.border.opacity(0.5)] :
                                            [LuxorColors.Light.border, LuxorColors.Light.border.opacity(0.5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: isEditing ? 2 : 1
                            )
                    )
                    .shadow(
                        color: themeManager.isDarkMode ?
                            LuxorColors.Dark.shadow :
                            LuxorColors.Light.shadow,
                        radius: isEditing ? 12 : 6,
                        x: 0,
                        y: isEditing ? 6 : 3
                    )
                    .frame(height: 64)

                HStack(spacing: 16) {
                    if !showValidation || !languageManager.currentLanguage.isRTL {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: isEditing ?
                                            themeManager.isDarkMode ?
                                                [LuxorColors.Dark.accent.opacity(0.2), LuxorColors.Dark.accentSecondary.opacity(0.2)] :
                                                [LuxorColors.Light.accent.opacity(0.2), LuxorColors.Light.accentSecondary.opacity(0.2)] :
                                            [Color.clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 36, height: 36)

                            Image(systemName: isEditing ? "lock.open.fill" : "lock.fill")
                                .foregroundColor(
                                    isEditing ?
                                        themeManager.isDarkMode ? LuxorColors.Dark.accent : LuxorColors.Light.accentSecondary :
                                        themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary
                                )
                                .font(.system(size: 18, weight: .medium))
                                .scaleEffect(isEditing ? 1.1 : 1.0)
                        }
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isEditing)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(LocalizedStrings.password(languageManager.currentLanguage))
                                .font(.system(
                                    size: (isEditing || !password.isEmpty) ? 11 : 16,
                                    weight: .medium
                                ))
                                .foregroundColor(
                                    isEditing ?
                                        themeManager.isDarkMode ? LuxorColors.Dark.accent : LuxorColors.Light.accentSecondary :
                                        themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary
                                )
                                .offset(y: (isEditing || !password.isEmpty) ? -8 : 8)
                                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isEditing || !password.isEmpty)
                            Spacer()
                        }
                        HStack {
                            Group {
                                if isSecure {
                                    SecureField("", text: $password)
                                } else {
                                    TextField("", text: $password)
                                }
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(
                                themeManager.isDarkMode ? LuxorColors.Dark.textPrimary : LuxorColors.Light.textPrimary
                            )
                            .onTapGesture {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    isEditing = true
                                }
                            }
                            .onChange(of: password) { newValue in
                                validatePassword(newValue)
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showValidation = !newValue.isEmpty
                                }
                            }
                        }
                    }
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            isSecure.toggle()
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(
                                    themeManager.isDarkMode ?
                                    Color.white.opacity(0.1) :
                                    Color.gray.opacity(0.1)
                                )
                                .frame(width: 32, height: 32)

                            Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(
                                    themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary
                                )
                                .font(.system(size: 16, weight: .medium))
                                .scaleEffect(isSecure ? 1.0 : 1.1)
                        }
                    }
                    .scaleEffect(1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSecure)

                    if showValidation && languageManager.currentLanguage.isRTL {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: isEditing ?
                                            themeManager.isDarkMode ?
                                                [LuxorColors.Dark.accent.opacity(0.2), LuxorColors.Dark.accentSecondary.opacity(0.2)] :
                                                [LuxorColors.Light.accent.opacity(0.2), LuxorColors.Light.accentSecondary.opacity(0.2)] :
                                            [Color.clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 36, height: 36)

                            Image(systemName: isEditing ? "lock.open.fill" : "lock.fill")
                                .foregroundColor(
                                    isEditing ?
                                        themeManager.isDarkMode ? LuxorColors.Dark.accent : LuxorColors.Light.accentSecondary :
                                        themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary
                                )
                                .font(.system(size: 18, weight: .medium))
                                .scaleEffect(isEditing ? 1.1 : 1.0)
                        }
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isEditing)
                    }
                }
                .padding(.horizontal, 20)
            }
            if showValidation {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Password Requirements")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(
                            themeManager.isDarkMode ? Color.white.opacity(0.8) : Color.black.opacity(0.8)
                        )
                    VStack(alignment: .leading, spacing: 8) {
                        EnhancedPasswordValidationRow(
                            text: "At least one capital letter",
                            isValid: validation.hasCapitalLetter,
                            themeManager: themeManager
                        )
                        EnhancedPasswordValidationRow(
                            text: "At least 8 characters",
                            isValid: validation.hasMinimumLength,
                            themeManager: themeManager
                        )
                        EnhancedPasswordValidationRow(
                            text: "At least one special character",
                            isValid: validation.hasSpecialCharacter,
                            themeManager: themeManager
                        )
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            themeManager.isDarkMode ?
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.03),
                                    Color.white.opacity(0.01)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ) :
                            LinearGradient(
                                colors: [
                                    Color(UIColor.systemGray6),
                                    Color.white.opacity(0.8)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    themeManager.isDarkMode ?
                                    Color.white.opacity(0.05) :
                                    Color.gray.opacity(0.1),
                                    lineWidth: 1
                                )
                        )
                )
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .move(edge: .top)).combined(with: .scale(scale: 0.95)),
                    removal: .opacity.combined(with: .move(edge: .top))
                ))
            }
        }
    }

    private func validatePassword(_ password: String) {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            validation.hasCapitalLetter = password.range(of: "[A-Z]", options: .regularExpression) != nil
            validation.hasMinimumLength = password.count >= 8
            validation.hasSpecialCharacter = password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil
        }
    }
}

struct EnhancedPasswordValidationRow: View {
    let text: String
    let isValid: Bool
    let themeManager: ThemeManager

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        isValid ?
                        LinearGradient(
                            colors: [Color.green, Color.green.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                        LinearGradient(
                            colors: [
                                themeManager.isDarkMode ? Color.white.opacity(0.1) : Color.gray.opacity(0.2),
                                themeManager.isDarkMode ? Color.white.opacity(0.05) : Color.gray.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 20, height: 20)

                Image(systemName: isValid ? "checkmark" : "")
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .bold))
                    .scaleEffect(isValid ? 1.0 : 0.0)
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isValid)

            Text(text)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(
                    isValid ? Color.green :
                    themeManager.isDarkMode ? Color.white.opacity(0.6) : Color.gray
                )
                .animation(.easeInOut(duration: 0.2), value: isValid)
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        LuxorPasswordTextField(password: .constant("Test123!"))
            .environmentObject(ThemeManager())
            .environmentObject(LanguageManager())
            .background(Color.white)
        LuxorPasswordTextField(password: .constant("Test123!"))
            .environmentObject(LanguageManager())
            .environmentObject({
                let theme = ThemeManager()
                theme.isDarkMode = true
                return theme
            }())
            .background(Color.black)
    }
    .padding()
}
