//
//  LoadingView.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//


import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    @EnvironmentObject var languageManager: LanguageManager

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .stroke(Color.blue.opacity(0.2), lineWidth: 4)
                        .frame(width: 60, height: 60)
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 4, lineCap: .round)
                        )
                        .frame(width: 60, height: 60)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            .linear(duration: 1.5).repeatForever(
                                autoreverses: false
                            ),
                            value: isAnimating
                        )
                }
                Text(
                    LocalizedStrings.authenticating(
                        languageManager.currentLanguage
                    )
                )
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
                .opacity(isAnimating ? 0.7 : 1.0)
                .animation(
                    .easeInOut(duration: 1.0).repeatForever(autoreverses: true),
                    value: isAnimating
                )
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.regularMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct PulsingCircleLoadingView: View {
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.6

    var body: some View {
        ZStack {
            ForEach(0..<3) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.blue.opacity(0.8), .purple.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 20, height: 20)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .animation(
                        .easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                        value: scale
                    )
                    .offset(x: CGFloat(index - 1) * 30)
            }
        }
        .onAppear {
            scale = 1.2
            opacity = 0.2
        }
    }
}

struct LoadingModifier: ViewModifier {
    //@EnvironmentObject var authState: AuthState

    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    LoadingView()
                        .transition(.opacity)
//                    if authState.isLoading {
//                        LoadingView()
//                            .transition(.opacity)
//                    }
                }
            )
    }
}

extension View {
    func withLoading() -> some View {
        self.modifier(LoadingModifier())
    }
}

#Preview {
    VStack {
        Text("Sample Content")
            .font(.title)
            .padding()
            .environmentObject(LanguageManager())

        Spacer()
    }
    .overlay(
        LoadingView()
    )
    .environmentObject(LanguageManager())
}
