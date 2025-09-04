//
//  Photo.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//

import Foundation

enum PhotoType: Int, Codable, CaseIterable {
    case userPhoto = 0
    case emiratesPhoto = 1
    case passportPhoto = 2

    var displayName: String {
        switch self {
        case .userPhoto:
            return "User Photo"
        case .emiratesPhoto:
            return "Emirates Photo"
        case .passportPhoto:
            return "Passport Photo"
        }
    }
}

struct Photo: Codable, Identifiable {
    let id: String
    let type: PhotoType
    let url: String
    let filename: String
    let size: Int64
    let mimeType: String
    let uploadedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case url
        case filename
        case size
        case mimeType = "mime_type"
        case uploadedAt = "uploaded_at"
    }
}


struct StandardResponse: Codable {
    let success: Bool
    let message: String
    let statusCode: Int32
    let timestamp: String
    let requestId: String
    let errors: [String]
    let metadata: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case statusCode = "status_code"
        case timestamp
        case requestId = "request_id"
        case errors
        case metadata
    }
}

struct PaginationMeta: Codable {
    let page: Int32
    let limit: Int32
    let total: Int32
    let totalPages: Int32
    let hasNext: Bool
    let hasPrev: Bool
    
    enum CodingKeys: String, CodingKey {
        case page
        case limit
        case total
        case totalPages = "total_pages"
        case hasNext = "has_next"
        case hasPrev = "has_prev"
    }
}

