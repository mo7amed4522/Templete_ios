//
//  User.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let countryCode: String
    let phone: String
    let isVerified: Bool
    let isActive: Bool
    let photos: [Photo]
    let createdAt: String
    let updatedAt: String



    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case countryCode = "country_code"
        case phone
        case isVerified = "is_verified"
        case isActive = "is_active"
        case photos
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }


    init(
        id: String="",
        firstName: String="",
        lastName: String="",
        email: String="",
        countryCode: String="",
        phone: String="",
        isVerified: Bool=false,
        isActive: Bool=false,
        photos: [Photo]=[],
        createdAt: String="",
        updatedAt: String=""
    ){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.countryCode = countryCode
        self.phone = phone
        self.isVerified = isVerified
        self.isActive = isActive
        self.photos = photos
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


struct CreateUserRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let countryCode: String
    let phone: String
    let password: String
    let confirmPassword: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case countryCode = "country_code"
        case phone
        case password
        case confirmPassword = "confirm_password"
    }
}

struct CreateUserResponse: Codable {
    let response: StandardResponse
    let user: User
}


struct GetUserRequest: Codable {
    let id: String
}

struct GetUserResponse: Codable {
    let response: StandardResponse
    let user: User
}


struct UpdateUserRequest: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let countryCode: String
    let phone: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case countryCode = "country_code"
        case phone
    }
}

struct UpdateUserResponse: Codable {
    let response: StandardResponse
    let user: User
}


struct DeleteUserRequest: Codable {
    let id: String
}

struct DeleteUserResponse: Codable {
    let response: StandardResponse
}

struct AuthenticateUserRequest: Codable {
    let email: String
    let password: String
}

struct AuthenticateUserResponse: Codable {
    let response: StandardResponse
    let accessToken: String
    let refreshToken: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case response
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case user
    }
}

struct ValidateTokenRequest: Codable {
    let token: String
}

struct ValidateTokenResponse: Codable {
    let response: StandardResponse
    let isValid: Bool
    let user: User

    enum CodingKeys: String, CodingKey {
        case response
        case isValid = "is_valid"
        case user
    }
}

struct RefreshTokenRequest: Codable {
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

struct RefreshTokenResponse: Codable {
    let response: StandardResponse
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case response
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

struct SendVerificationCodeRequest: Codable {
    let userId: String
    let method: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case method
    }
}

struct SendVerificationCodeResponse: Codable {
    let response: StandardResponse
    let verificationId: String
    
    enum CodingKeys: String, CodingKey {
        case response
        case verificationId = "verification_id"
    }
}


struct VerifyCodeRequest: Codable {
    let verificationId: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case verificationId = "verification_id"
        case code
    }
}

struct VerifyCodeResponse: Codable {
    let response: StandardResponse
    let isVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case response
        case isVerified = "is_verified"
    }
}


struct UploadPhotoRequest: Codable {
    let userId: String
    let photoType: PhotoType
    let fileData: Data
    let filename: String
    let mimeType: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case photoType = "photo_type"
        case fileData = "file_data"
        case filename
        case mimeType = "mime_type"
    }
}

struct UploadPhotoResponse: Codable {
    let response: StandardResponse
    let photo: Photo
}

// Get User Photos
struct GetUserPhotosRequest: Codable {
    let userId: String
    let photoType: PhotoType
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case photoType = "photo_type"
    }
}

struct GetUserPhotosResponse: Codable {
    let response: StandardResponse
    let photos: [Photo]
}

