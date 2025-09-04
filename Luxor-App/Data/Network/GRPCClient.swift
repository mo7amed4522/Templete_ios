//
//  GRPCClient.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Combine
import Foundation
import GRPCCore
import GRPCNIOTransportHTTP2
import GRPCProtobuf


@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
class GRPCClientManager {
    private let serviesHost = "localhost"
    private let serviesPort = 50051
    
    func login(email: String , password: String)async throws-> User_AuthenticateUserResponse{
        return try await withGRPCClient(
            transport: .http2NIOPosix(
                target: .dns(host: serviesHost, port: serviesPort),
                transportSecurity: .plaintext
            )
        ){
            client in
            let services = User_UserService.Client(wrapping: client)
            
            let request = User_AuthenticateUserRequest.with{
                $0.email = email
                $0.password = password
            }
            
            let response = try await services.authenticateUser(request)
            
            return response
        }
    }
}

extension GRPCClientManager {
    private func convertToDomainUser(from grpcUser: User_User) -> User {
        return User(
            id: grpcUser.id,
            firstName: grpcUser.firstName,
            lastName: grpcUser.lastName,
            email: grpcUser.email,
            countryCode: grpcUser.counntryCode,
            phone: grpcUser.phone,
            isVerified: grpcUser.isVerified,
            isActive: grpcUser.isActive,
            photos: grpcUser.photos.map { convertToDomainPhoto(from: $0) },
            createdAt: grpcUser.createdAt,
            updatedAt: grpcUser.updatedAt
        )
    }
    
    private func convertToDomainPhoto(from grpcPhoto: Common_Photo) -> Photo {
        return Photo(
            id: grpcPhoto.id,
            type: PhotoType(rawValue: Int(grpcPhoto.type.rawValue)) ?? .userPhoto,
            url: grpcPhoto.url,
            filename: grpcPhoto.filename,
            size: grpcPhoto.size,
            mimeType: grpcPhoto.mimeType,
            uploadedAt: grpcPhoto.uploadedAt
        )
    }
    
    private func convertToDomainStandardResponse(from grpcResponse: Common_StandardResponse) -> StandardResponse {
        return StandardResponse(
            success: grpcResponse.success,
            message: grpcResponse.message,
            statusCode: grpcResponse.statusCode,
            timestamp: grpcResponse.timestamp,
            requestId: grpcResponse.requestID,
            errors: Array(grpcResponse.errors),
            metadata: Dictionary(uniqueKeysWithValues: grpcResponse.metadata.map { ($0.key, $0.value) })
        )
    }
    
    func convertToDomainAuthResponse(from grpcResponse: User_AuthenticateUserResponse) -> AuthenticateUserResponse {
        return AuthenticateUserResponse(
            response: convertToDomainStandardResponse(from: grpcResponse.response),
            accessToken: grpcResponse.accessToken,
            refreshToken: grpcResponse.refreshToken,
            user: convertToDomainUser(from: grpcResponse.user)
        )
    }
}
