import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }

    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }

    func toggleTheme() {
        isDarkMode.toggle()
    }
}

struct LuxorColors {

    // Enhanced Gold Palette
    static let pureGold = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let richGold = Color(red: 0.85, green: 0.65, blue: 0.13)
    static let deepGold = Color(red: 0.72, green: 0.53, blue: 0.04)
    static let bronzeGold = Color(red: 0.8, green: 0.5, blue: 0.2)
    static let lightGold = Color(red: 1.0, green: 0.92, blue: 0.4)
    static let darkGold = Color(red: 0.6, green: 0.4, blue: 0.0)

    // Enhanced Blue Palette
    static let egyptianBlue = Color(red: 0.06, green: 0.32, blue: 0.73)
    static let lightBlue = Color(red: 0.2, green: 0.5, blue: 0.9)
    static let darkBlue = Color(red: 0.02, green: 0.15, blue: 0.4)
    static let royalBlue = Color(red: 0.1, green: 0.4, blue: 0.8)
    
    // Enhanced Neutral Palette
    static let papyrusBeige = Color(red: 0.96, green: 0.87, blue: 0.70)
    static let sandstone = Color(red: 0.93, green: 0.84, blue: 0.68)
    static let hieroglyphBrown = Color(red: 0.4, green: 0.26, blue: 0.13)
    static let warmWhite = Color(red: 0.98, green: 0.96, blue: 0.92)
    static let deepBrown = Color(red: 0.2, green: 0.12, blue: 0.06)

    static let luxorTeal = egyptianBlue
    static let luxorGold = pureGold
    static let luxorDarkTeal = darkBlue

    struct Light {
        static let background = warmWhite
        static let secondaryBackground = papyrusBeige
        static let textPrimary = deepBrown
        static let textSecondary = hieroglyphBrown
        static let cardBackground = Color.white
        static let inputBackground = Color.white
        static let shadow = hieroglyphBrown.opacity(0.12)
        static let accent = richGold
        static let accentSecondary = egyptianBlue
        static let border = richGold.opacity(0.4)
        static let borderSecondary = egyptianBlue.opacity(0.3)
        static let success = Color.green
        static let error = Color.red
        static let warning = Color.orange
    }

    struct Dark {
        static let background = Color(red: 0.05, green: 0.04, blue: 0.02)
        static let secondaryBackground = Color(red: 0.1, green: 0.08, blue: 0.05)
        static let textPrimary = lightGold
        static let textSecondary = Color(red: 0.9, green: 0.8, blue: 0.6)
        static let cardBackground = Color(red: 0.12, green: 0.1, blue: 0.07)
        static let inputBackground = Color(red: 0.15, green: 0.12, blue: 0.08)
        static let shadow = Color.black.opacity(0.8)
        static let accent = pureGold
        static let accentSecondary = lightBlue
        static let border = pureGold.opacity(0.6)
        static let borderSecondary = lightBlue.opacity(0.5)
        static let success = Color.green.opacity(0.9)
        static let error = Color.red.opacity(0.9)
        static let warning = Color.orange.opacity(0.9)
    }
}

extension View {
    func luxorThemedBackground(_ themeManager: ThemeManager) -> some View {
        self.background(
            LinearGradient(
                colors: themeManager.isDarkMode
                    ? [
                        LuxorColors.Dark.background,
                        LuxorColors.Dark.secondaryBackground,
                    ]
                    : [
                        LuxorColors.Light.background,
                        LuxorColors.Light.secondaryBackground,
                    ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    func luxorCard(_ themeManager: ThemeManager) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        themeManager.isDarkMode
                            ? LuxorColors.Dark.cardBackground
                            : LuxorColors.Light.cardBackground
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        LuxorColors.pureGold.opacity(0.3),
                                        LuxorColors.richGold.opacity(0.2),
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(
                        color: themeManager.isDarkMode
                            ? LuxorColors.Dark.shadow
                            : LuxorColors.Light.shadow,
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            )
    }

    func historicalButton(_ themeManager: ThemeManager, isEnabled: Bool = true)
        -> some View
    {
        self
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: isEnabled
                                ? [
                                    LuxorColors.pureGold,
                                    LuxorColors.richGold,
                                    LuxorColors.deepGold,
                                ]
                                : [
                                    Color.gray.opacity(0.3),
                                    Color.gray.opacity(0.2),
                                ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                LuxorColors.hieroglyphBrown.opacity(0.3),
                                lineWidth: 1
                            )
                    )
                    .shadow(
                        color: LuxorColors.hieroglyphBrown.opacity(0.3),
                        radius: 4,
                        x: 0,
                        y: 2
                    )
            )
    }
}
