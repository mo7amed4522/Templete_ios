import SwiftUI

struct LuxorEmailTextField: View {
    @Binding var email: String
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var languageManager: LanguageManager
    @State private var isEditing = false
    @State private var isValid = true
    @State private var showValidation = false

    private var backgroundGradient: LinearGradient {
        if themeManager.isDarkMode {
            return LinearGradient(
                colors: [
                    LuxorColors.Dark.inputBackground,
                    LuxorColors.Dark.cardBackground
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                colors: [
                    LuxorColors.Light.inputBackground,
                    LuxorColors.Light.cardBackground
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private var borderGradient: LinearGradient {
        if isEditing {
            return LinearGradient(
                colors: themeManager.isDarkMode ?
                    [LuxorColors.Dark.accent, LuxorColors.Dark.accentSecondary] :
                    [LuxorColors.Light.accent, LuxorColors.Light.accentSecondary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else if !isValid {
            return LinearGradient(
                colors: themeManager.isDarkMode ?
                    [LuxorColors.Dark.error, LuxorColors.Dark.error.opacity(0.6)] :
                    [LuxorColors.Light.error, LuxorColors.Light.error.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                colors: themeManager.isDarkMode ?
                    [LuxorColors.Dark.border, LuxorColors.Dark.border.opacity(0.5)] :
                    [LuxorColors.Light.border, LuxorColors.Light.border.opacity(0.5)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private var iconBackgroundGradient: LinearGradient {
        if isEditing {
            return LinearGradient(
                colors: [LuxorColors.luxorTeal.opacity(0.2), LuxorColors.luxorGold.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                colors: [Color.clear],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private var iconColor: Color {
        if isEditing {
            return themeManager.isDarkMode ? LuxorColors.Dark.accent : LuxorColors.Light.accentSecondary
        } else if !isValid {
            return themeManager.isDarkMode ? LuxorColors.Dark.error : LuxorColors.Light.error
        } else {
            return themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary
        }
    }

    private var labelColor: Color {
        if isEditing {
            return themeManager.isDarkMode ? LuxorColors.Dark.accent : LuxorColors.Light.accentSecondary
        } else if !isValid {
            return themeManager.isDarkMode ? LuxorColors.Dark.error : LuxorColors.Light.error
        } else {
            return themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary
        }
    }

    private var textColor: Color {
        return themeManager.isDarkMode ? LuxorColors.Dark.textPrimary : LuxorColors.Light.textPrimary
    }

    private var shadowColor: Color {
        return themeManager.isDarkMode ? LuxorColors.Dark.shadow : LuxorColors.Light.shadow
    }

    private var validationIconGradient: LinearGradient {
        if email.isEmpty {
            return LinearGradient(colors: [Color.clear], startPoint: .top, endPoint: .bottom)
        } else if isValid {
            return LinearGradient(
                colors: [Color.green.opacity(0.2), Color.green.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                colors: [Color.red.opacity(0.2), Color.red.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderGradient, lineWidth: isEditing ? 2 : 1)
                    )
                    .shadow(
                        color: shadowColor,
                        radius: isEditing ? 12 : 6,
                        x: 0,
                        y: isEditing ? 6 : 3
                    )
                    .frame(height: 64)

                HStack(spacing: languageManager.currentLanguage.isRTL ? 16 : 16) {
                    if !languageManager.currentLanguage.isRTL {
                        ZStack {
                            Circle()
                                .fill(iconBackgroundGradient)
                                .frame(width: 36, height: 36)

                            Image(systemName: isEditing ? "envelope.open.fill" : "envelope.fill")
                                .foregroundColor(iconColor)
                                .font(.system(size: 18, weight: .medium))
                                .scaleEffect(isEditing ? 1.1 : 1.0)
                        }
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isEditing)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(LocalizedStrings.emailAddress(languageManager.currentLanguage))
                                .font(.system(
                                    size: (isEditing || !email.isEmpty) ? 11 : 16,
                                    weight: .medium
                                ))
                                .foregroundColor(labelColor)
                                .offset(y: (isEditing || !email.isEmpty) ? -8 : 8)
                                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isEditing || !email.isEmpty)
                            Spacer()
                        }
                        HStack {
                            TextField("", text: $email)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(textColor)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        isEditing = true
                                    }
                                }
                                .onChange(of: email) { newValue in
                                    validateEmail(newValue)
                                }
                                .onSubmit {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        isEditing = false
                                    }
                                }
                        }
                    }
                    ZStack {
                        Circle()
                            .fill(validationIconGradient)
                            .frame(width: 32, height: 32)

                        if !email.isEmpty {
                            Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(isValid ?
                                    (themeManager.isDarkMode ? LuxorColors.Dark.success : LuxorColors.Light.success) :
                                    (themeManager.isDarkMode ? LuxorColors.Dark.error : LuxorColors.Light.error)
                                )
                                .font(.system(size: 16, weight: .medium))
                                .scaleEffect(isValid ? 1.1 : 1.0)
                        }
                    }
                    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isValid)
                    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: email.isEmpty)

                    if languageManager.currentLanguage.isRTL {
                        ZStack {
                            Circle()
                                .fill(iconBackgroundGradient)
                                .frame(width: 36, height: 36)

                            Image(systemName: isEditing ? "envelope.open.fill" : "envelope.fill")
                                .foregroundColor(iconColor)
                                .font(.system(size: 18, weight: .medium))
                                .scaleEffect(isEditing ? 1.1 : 1.0)
                        }
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isEditing)
                    }
                }
                .padding(.horizontal, 20)
            }
            if !isValid && !email.isEmpty {
                HStack(spacing: 8) {
                    if !languageManager.currentLanguage.isRTL {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.error : LuxorColors.Light.error)
                            .font(.system(size: 12))
                    }

                    Text(LocalizedStrings.pleaseEnterValidEmail(languageManager.currentLanguage))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.error : LuxorColors.Light.error)

                    if languageManager.currentLanguage.isRTL {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.error : LuxorColors.Light.error)
                            .font(.system(size: 12))
                    }
                }
                .padding(.horizontal, 4)
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .move(edge: .top)).combined(with: .scale(scale: 0.95)),
                    removal: .opacity.combined(with: .move(edge: .top))
                ))
            }
        }
        .onTapGesture {
            if !isEditing {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    isEditing = true
                }
            }
        }
    }

    private func validateEmail(_ email: String) {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            isValid = email.isEmpty || emailPredicate.evaluate(with: email)
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        LuxorEmailTextField(email: .constant("user@example.com"))
            .environmentObject(ThemeManager())
            .environmentObject(LanguageManager())
            .background(Color.white)
        LuxorEmailTextField(email: .constant("user@example.com"))
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
