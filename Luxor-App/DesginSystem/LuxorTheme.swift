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

    static let pureGold = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let richGold = Color(red: 0.85, green: 0.65, blue: 0.13)
    static let deepGold = Color(red: 0.72, green: 0.53, blue: 0.04)
    static let bronzeGold = Color(red: 0.8, green: 0.5, blue: 0.2)

    static let egyptianBlue = Color(red: 0.06, green: 0.32, blue: 0.73)
    static let papyrusBeige = Color(red: 0.96, green: 0.87, blue: 0.70)
    static let sandstone = Color(red: 0.93, green: 0.84, blue: 0.68)
    static let hieroglyphBrown = Color(red: 0.4, green: 0.26, blue: 0.13)

    static let luxorTeal = egyptianBlue
    static let luxorGold = pureGold
    static let luxorDarkTeal = Color(red: 0.04, green: 0.24, blue: 0.55)

    struct Light {
        static let background = Color(red: 0.98, green: 0.95, blue: 0.88)
        static let secondaryBackground = papyrusBeige
        static let textPrimary = hieroglyphBrown
        static let textSecondary = Color(red: 0.5, green: 0.4, blue: 0.3)
        static let cardBackground = Color(red: 0.99, green: 0.96, blue: 0.90)
        static let shadow = hieroglyphBrown.opacity(0.15)
        static let accent = pureGold
        static let border = richGold.opacity(0.3)
    }

    struct Dark {
        static let background = Color(red: 0.08, green: 0.06, blue: 0.04)
        static let secondaryBackground = Color(
            red: 0.12,
            green: 0.10,
            blue: 0.08
        )
        static let textPrimary = pureGold
        static let textSecondary = Color(red: 0.85, green: 0.75, blue: 0.55)
        static let cardBackground = Color(red: 0.15, green: 0.12, blue: 0.08)
        static let shadow = Color.black.opacity(0.6)
        static let accent = richGold
        static let border = deepGold.opacity(0.4)
        static let inputBackground = Color(red: 0.18, green: 0.15, blue: 0.10)
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
