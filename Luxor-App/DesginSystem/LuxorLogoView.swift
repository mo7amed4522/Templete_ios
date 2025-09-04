import SwiftUI

struct LuxorLogoView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let size: CGFloat
    @State private var isAnimating = false
    
    init(size: CGFloat = 120) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            LuxorColors.luxorTeal.opacity(themeManager.isDarkMode ? 0.3 : 0.1),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: size * 0.3,
                        endRadius: size * 0.8
                    )
                )
                .frame(width: size * 1.4, height: size * 1.4)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .opacity(isAnimating ? 0.7 : 1.0)
                .animation(
                    .easeInOut(duration: 2.0).repeatForever(autoreverses: true),
                    value: isAnimating
                )
            ZStack {
                Circle()
                    .fill(
                        AngularGradient(
                            colors: [
                                LuxorColors.luxorTeal,
                                LuxorColors.luxorGold,
                                LuxorColors.luxorTeal.opacity(0.8),
                                LuxorColors.luxorGold.opacity(0.9),
                                LuxorColors.luxorTeal
                            ],
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        )
                    )
                    .frame(width: size, height: size)
                    .shadow(
                        color: themeManager.isDarkMode ?
                            LuxorColors.luxorTeal.opacity(0.4) :
                            Color.black.opacity(0.15),
                        radius: 20,
                        x: 0,
                        y: 10
                    )
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(themeManager.isDarkMode ? 0.2 : 0.4),
                                        Color.clear,
                                        Color.black.opacity(themeManager.isDarkMode ? 0.1 : 0.05)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                Circle()
                    .fill(
                        themeManager.isDarkMode ?
                        LinearGradient(
                            colors: [
                                Color.black.opacity(0.8),
                                Color.black.opacity(0.6),
                                Color.black.opacity(0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                        LinearGradient(
                            colors: [
                                Color.white,
                                Color.white.opacity(0.95),
                                Color(UIColor.systemGray6).opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size - 12, height: size - 12)
                    .overlay(
                        Circle()
                            .stroke(
                                themeManager.isDarkMode ?
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.1),
                                        Color.clear,
                                        Color.white.opacity(0.05)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ) :
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.8),
                                        Color.clear,
                                        Color.gray.opacity(0.1)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    LuxorColors.luxorTeal.opacity(0.1),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: size * 0.3
                            )
                        )
                        .frame(width: size - 20, height: size - 20)
                    Image("logo-nobg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size - 32, height: size - 32)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(themeManager.isDarkMode ? 0.1 : 0.3),
                                            Color.clear
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                        .shadow(
                            color: themeManager.isDarkMode ?
                                Color.black.opacity(0.3) :
                                Color.black.opacity(0.1),
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                }
            }
            .scaleEffect(isAnimating ? 1.02 : 1.0)
            .animation(
                .easeInOut(duration: 3.0).repeatForever(autoreverses: true),
                value: isAnimating
            )
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(themeManager.isDarkMode ? 0.1 : 0.3),
                            Color.clear
                        ],
                        startPoint: .topLeading,
                        endPoint: .center
                    )
                )
                .frame(width: size * 0.4, height: size * 0.4)
                .offset(x: -size * 0.15, y: -size * 0.15)
                .blur(radius: 8)
        }
        .onAppear {
            withAnimation {
                isAnimating = true
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {

        LuxorLogoView(size: 150)
            .environmentObject(ThemeManager())

        LuxorLogoView(size: 150)
            .environmentObject({
                let theme = ThemeManager()
                theme.isDarkMode = true
                return theme
            }())
            
    }
    .padding()
}
