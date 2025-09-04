//
//  DIContainer.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Foundation
import Combine

class DIContainer: ObservableObject {
    static let shared = DIContainer()


    lazy var authState: AuthState = {
        return AuthState()
    }()

    lazy var themeManager: ThemeManager = {
        return ThemeManager()
    }()

    lazy var languageManager: LanguageManager = {
        return LanguageManager()
    }()


    lazy var grpcClient: GRPCClientManager = {
        return GRPCClientManager()
    }()

    lazy var authRepository: AuthRepositoryProtocol = {
        return AuthRepository(grpcClient: grpcClient)
    }()


    lazy var authUseCase: AuthUseCase = {
        return AuthUseCase(authRepository: authRepository as! AuthRepository)
    }()


    lazy var userDataManager: UserDataManager = {
        return UserDataManager()
    }()

    private init() {}


    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(
            authUseCase: authUseCase,
            authState: authState
        )
    }
}
