//
//  Luxor_AppApp.swift
//  Luxor-App
//
//  Created by Standard User on 16/08/2025.
//

import SwiftUI

@main
struct Luxor_AppApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }
    }
}
