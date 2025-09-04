//
//  UserDataManager.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Foundation
import Combine

class UserDataManager: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false

    private let userDefaults = UserDefaults.standard
    private let userKey = "current_user"
    private let tokenKey = "access_token"
    private let refreshTokenKey = "refresh_token"

    init() {
        loadUserData()
    }


    func saveUser(_ user: User, authResponse: AuthenticateUserResponse) {
        do {
            let userData = try JSONEncoder().encode(user)
            userDefaults.set(userData, forKey: userKey)
            userDefaults.set(authResponse.accessToken, forKey: tokenKey)
            userDefaults.set(authResponse.refreshToken, forKey: refreshTokenKey)

            DispatchQueue.main.async {
                self.currentUser = user
                self.isLoggedIn = true
            }
        } catch {
            print("Failed to save user data: \(error)")
        }
    }

    func loadUserData() {
        guard let userData = userDefaults.data(forKey: userKey),
              let user = try? JSONDecoder().decode(User.self, from: userData),
              let _ = userDefaults.string(forKey: tokenKey) else {
            return
        }

        DispatchQueue.main.async {
            self.currentUser = user
            self.isLoggedIn = true
        }
    }

    func clearUserData() {
        userDefaults.removeObject(forKey: userKey)
        userDefaults.removeObject(forKey: tokenKey)
        userDefaults.removeObject(forKey: refreshTokenKey)

        DispatchQueue.main.async {
            self.currentUser = nil
            self.isLoggedIn = false
        }
    }


    func getAccessToken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }

    func getRefreshToken() -> String? {
        return userDefaults.string(forKey: refreshTokenKey)
    }

    func updateTokens(accessToken: String, refreshToken: String) {
        userDefaults.set(accessToken, forKey: tokenKey)
        userDefaults.set(refreshToken, forKey: refreshTokenKey)
    }


    func updateUser(_ user: User) {
        do {
            let userData = try JSONEncoder().encode(user)
            userDefaults.set(userData, forKey: userKey)

            DispatchQueue.main.async {
                self.currentUser = user
            }
        } catch {
            print("Failed to update user data: \(error)")
        }
    }
}

