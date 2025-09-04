//
//  AuthUseCase.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Foundation
import Combine


class AuthUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func login(email: String, password: String) -> AnyPublisher<Result<AuthenticateUserResponse, AuthError>, Never> {
        let credentials = AuthenticateUserRequest(
            email: email, password: password
        )
        
        return authRepository.login(credentials: credentials)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(response)
                case .failure(let error):
                    if let authError = error as? AuthError {
                        return .failure(authError)
                    } else {
                        return .failure(.unknownError)
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}
