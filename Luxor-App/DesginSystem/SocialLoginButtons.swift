import SwiftUI

struct SocialLoginButtons: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text(LocalizedStrings.orContinueWith(languageManager.currentLanguage))
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary)
            
            HStack(spacing: 20) {
                if languageManager.currentLanguage.isRTL {
                    SocialButton(
                        icon: "f.circle.fill",
                        color: themeManager.isDarkMode ? LuxorColors.Dark.accent : LuxorColors.Light.accentSecondary,
                        action: { /* Facebook Sign In */ }
                    )
                    
                    SocialButton(
                        icon: "globe",
                        color: themeManager.isDarkMode ? LuxorColors.Dark.error : LuxorColors.Light.error,
                        action: { /* Google Sign In */ }
                    )
                    
                    SocialButton(
                        icon: "apple.logo",
                        color: themeManager.isDarkMode ? LuxorColors.Dark.textPrimary : LuxorColors.Light.textPrimary,
                        action: { /* Apple Sign In */ }
                    )
                } else {
                    SocialButton(
                        icon: "apple.logo",
                        color: themeManager.isDarkMode ? LuxorColors.Dark.textPrimary : LuxorColors.Light.textPrimary,
                        action: { /* Apple Sign In */ }
                    )
                    
                    SocialButton(
                        icon: "globe",
                        color: themeManager.isDarkMode ? LuxorColors.Dark.error : LuxorColors.Light.error,
                        action: { /* Google Sign In */ }
                    )
                    
                    SocialButton(
                        icon: "f.circle.fill",
                        color: themeManager.isDarkMode ? LuxorColors.Dark.accent : LuxorColors.Light.accentSecondary,
                        action: { /* Facebook Sign In */ }
                    )
                }
            }
        }
    }
}

struct SocialButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    @EnvironmentObject var themeManager: ThemeManager
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    themeManager.isDarkMode ? LuxorColors.Dark.cardBackground : LuxorColors.Light.cardBackground,
                                    themeManager.isDarkMode ? LuxorColors.Dark.inputBackground : LuxorColors.Light.inputBackground
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            themeManager.isDarkMode ? LuxorColors.Dark.border : LuxorColors.Light.border,
                                            themeManager.isDarkMode ? LuxorColors.Dark.border.opacity(0.5) : LuxorColors.Light.border.opacity(0.5)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                        .shadow(
                            color: themeManager.isDarkMode ? LuxorColors.Dark.shadow : LuxorColors.Light.shadow,
                            radius: isPressed ? 3 : 8,
                            x: 0,
                            y: isPressed ? 1 : 4
                        )
                )
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}
#Preview {
    SocialLoginButtons()
        .environmentObject(ThemeManager())
        .environmentObject(LanguageManager())
}
