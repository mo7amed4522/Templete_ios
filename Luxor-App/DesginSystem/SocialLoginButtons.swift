import SwiftUI

struct SocialLoginButtons: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Or continue with")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary)
            
            HStack(spacing: 20) {
                SocialButton(
                    icon: "apple.logo",
                    color: themeManager.isDarkMode ? .white : .black,
                    action: { /* Apple Sign In */ }
                )
                
                SocialButton(
                    icon: "globe",
                    color: .red,
                    action: { /* Google Sign In */ }
                )
                
                SocialButton(
                    icon: "f.circle.fill",
                    color: .blue,
                    action: { /* Facebook Sign In */ }
                )
            }
        }
    }
}

struct SocialButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(themeManager.isDarkMode ? LuxorColors.Dark.cardBackground : LuxorColors.Light.cardBackground)
                        .shadow(
                            color: themeManager.isDarkMode ? LuxorColors.Dark.shadow : LuxorColors.Light.shadow,
                            radius: 5,
                            x: 0,
                            y: 2
                        )
                )
        }
        .scaleEffect(1.0)
        .animation(.easeInOut(duration: 0.1), value: false)
    }
}
#Preview {
    SocialLoginButtons()
        .environmentObject(ThemeManager())
}
