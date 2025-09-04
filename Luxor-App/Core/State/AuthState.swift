//
//  AuthState.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Combine
import Foundation
import SwiftUI

class AuthState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    @Published var accessToken: String?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""
    @Published var toastType: ToastType = .success

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadStoredAuthData()
    }

    func login(user: User, authResponse: AuthenticateUserResponse) {
        DispatchQueue.main.async {
            self.currentUser = user
            self.accessToken = authResponse.accessToken
            self.isAuthenticated = true
            self.saveAuthData(user: user, token: authResponse.accessToken)
        }
    }

    func logout() {
        DispatchQueue.main.async {
            self.currentUser = nil
            self.accessToken = nil
            self.isAuthenticated = false
            self.clearStoredAuthData()
        }
    }

    func setLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = loading
        }
    }

    func setError(_ message: String?) {
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }

    func showSuccessToast(_ message: String) {
        DispatchQueue.main.async {
            self.toastMessage = message
            self.toastType = .success
            self.showToast = true
        }
    }

    func showErrorToast(_ message: String) {
        DispatchQueue.main.async {
            self.toastMessage = message
            self.toastType = .error
            self.showToast = true
        }
    }

    func hideToast() {
        DispatchQueue.main.async {
            self.showToast = false
        }
    }

    private func saveAuthData(user: User, token: String) {
        UserDefaults.standard.set(token, forKey: "access_token")
        if let userData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(userData, forKey: "user_data")
        }
    }

    private func loadStoredAuthData() {
        if let token = UserDefaults.standard.string(forKey: "access_token"),
            let userData = UserDefaults.standard.data(forKey: "user_data"),
            let user = try? JSONDecoder().decode(User.self, from: userData)
        {
            self.accessToken = token
            self.currentUser = user
            self.isAuthenticated = true
        }
    }

    private func clearStoredAuthData() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "user_data")
    }
}

enum ToastType {
    case success
    case error
    case info
    
    var color: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .info:
            return .blue
        }
    }
    
    var icon: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.circle.fill"
        case .info:
            return "info.circle.fill"
        }
        
    }
}
