//
//  AuthRepository.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Foundation
import Combine


class AuthRepository: AuthRepositoryProtocol {
    func login(credentials: AuthenticateUserRequest) -> AnyPublisher<Result<AuthenticateUserResponse, Error>, Never> {
        return Future<Result<AuthenticateUserResponse, Error>, Never> { [weak self] promise in
            guard let self = self else {
                promise(.success(.failure(AuthError.unknownError)))
                return
            }
            if credentials.email.isEmpty || credentials.password.isEmpty {
                promise(.success(.failure(AuthError.invalidCredentials)))
                return
            }
            
            Task {
                do {
                    let grpcResponse = try await self.grpcClient.login(
                        email: credentials.email,
                        password: credentials.password
                    )
                    let domainResponse = self.grpcClient.convertToDomainAuthResponse(from: grpcResponse)
                    if domainResponse.response.success {
                        promise(.success(.success(domainResponse)))
                    } else {
                        let errorMessage = domainResponse.response.message.isEmpty ? "Authentication failed" : domainResponse.response.message
                        promise(.success(.failure(AuthError.serverError(errorMessage))))
                    }
                } catch {
                    let authError = self.mapGRPCError(error)
                    promise(.success(.failure(authError)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func mapGRPCError(_ error: Error) -> AuthError {
        let errorDescription = error.localizedDescription.lowercased()
        if errorDescription.contains("network") || errorDescription.contains("connection") {
            return .networkError
        } else if errorDescription.contains("decode") || errorDescription.contains("parsing") {
            return .decodingError
        } else if errorDescription.contains("unauthorized") || errorDescription.contains("invalid credentials") {
            return .invalidCredentials
        } else {
            return .serverError(error.localizedDescription)
        }
    }
    
    private let grpcClient: GRPCClientManager
    private var cancellables: Set<AnyCancellable> = []
    
    init(grpcClient: GRPCClientManager) {
        self.grpcClient = grpcClient
    }
    

}
