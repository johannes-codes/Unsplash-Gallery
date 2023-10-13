//
//  Unsplash.swift
//  Unsplash Gallery
//
//  Created by Meißner, Johannes, HSE DE on 13.10.23.
//

import Foundation

// MARK: - Unsplash
struct Unsplash: Codable {
    let id: String
    let createdAt: Date
    let updatedAt: Date
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let downloads: Int
    let likes: Int
    let likedByUser: Bool
    let description: String
    let exif: Exif
    let location: Location
    let currentUserCollections: [CurrentUserCollection]
    let urls: Urls
    let links: UnsplashLinks
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case blurHash = "blur_hash"
        case downloads = "downloads"
        case likes = "likes"
        case likedByUser = "liked_by_user"
        case description = "description"
        case exif = "exif"
        case location = "location"
        case currentUserCollections = "current_user_collections"
        case urls = "urls"
        case links = "links"
        case user = "user"
    }
}

// MARK: - CurrentUserCollection
struct CurrentUserCollection: Codable {
    let id: Int
    let title: String
    let publishedAt: Date
    let lastCollectedAt: Date
    let updatedAt: Date
    let coverPhoto: JSONNull?
    let user: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case coverPhoto = "cover_photo"
        case user = "user"
    }
}

// MARK: - Exif
struct Exif: Codable {
    let make: String
    let model: String
    let exposureTime: String
    let aperture: String
    let focalLength: String
    let iso: Int
    
    enum CodingKeys: String, CodingKey {
        case make = "make"
        case model = "model"
        case exposureTime = "exposure_time"
        case aperture = "aperture"
        case focalLength = "focal_length"
        case iso = "iso"
    }
}

// MARK: - UnsplashLinks
struct UnsplashLinks: Codable {
    let linksSelf: String
    let html: String
    let download: String
    let downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html = "html"
        case download = "download"
        case downloadLocation = "download_location"
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let city: String
    let country: String
    let position: Position
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case city = "city"
        case country = "country"
        case position = "position"
    }
}

// MARK: - Position
struct Position: Codable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    
    enum CodingKeys: String, CodingKey {
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let updatedAt: Date
    let username: String
    let name: String
    let portfoliourl: String
    let bio: String
    let location: String
    let totalLikes: Int
    let totalPhotos: Int
    let totalCollections: Int
    let instagramUsername: String
    let twitterUsername: String
    let links: UserLinks
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case updatedAt = "updated_at"
        case username = "username"
        case name = "name"
        case portfoliourl = "portfolio_url"
        case bio = "bio"
        case location = "location"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case instagramUsername = "instagram_username"
        case twitterUsername = "twitter_username"
        case links = "links"
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html = "html"
        case photos = "photos"
        case likes = "likes"
        case portfolio = "portfolio"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
