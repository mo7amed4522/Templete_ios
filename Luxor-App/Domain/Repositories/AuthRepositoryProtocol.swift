//
//  AuthRepositoryProtocol.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Foundation
import Combine

enum AuthError: Error {
    case invalidCredentials
    case networkError
    case serverError(String)
    case decodingError
    case unknownError
}

protocol AuthRepositoryProtocol {
    func login(credentials: AuthenticateUserRequest) -> AnyPublisher<Result<AuthenticateUserResponse, Error>, Never>
}

