//
//  ItemResponse.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//


struct ItemResponse: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [ResultGame]?
    var seoTitle, seoDescription, seoKeywords, seoH1: String?
    var noindex, nofollow: Bool?
    var description: String?
    var filters: Filters?
    var nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow, description, filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    var years: [FiltersYear]?
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    var from, to: Int?
    var filter: String?
    var decade: Int?
    var years: [YearYear]?
    var nofollow: Bool?
    var count: Int?
}

// MARK: - YearYear
struct YearYear: Codable {
    var year, count: Int?
    var nofollow: Bool?
}

// MARK: - Result
struct ResultGame: Codable {
    var id: Int?
    var slug, name, released: String?
    var tba: Bool?
    var backgroundImage: String?
    var rating: Double?
    var ratingTop: Int?
    var ratings: [Rating]?
    var ratingsCount, reviewsTextCount, added: Int?
    var addedByStatus: AddedByStatus?
    var metacritic, playtime, suggestionsCount: Int?
    var updated: String?
    var userGame: String?
    var reviewsCount: Int?
    var saturatedColor, dominantColor: Color?
    var platforms: [PlatformElement]?
    var parentPlatforms: [ParentPlatform]?
    var genres: [Genre]?
    var stores: [Store]?
    var clip: String?
    var tags: [Genre]?
    var esrbRating: EsrbRating?
    var shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores, clip, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
    
    func toDomain() -> Game {
        return Game(id: id ?? -1, name: name ?? "", backgroundImage: backgroundImage ?? "", release: released ?? "", rating: rating ?? 0.0, description: "")
    }
}



// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    var yet, owned, beaten, toplay: Int?
    var dropped, playing: Int?
}

enum Color: String, Codable {
    case the0F0F0F = "0f0f0f"
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    var id: Int?
    var name, slug: String?
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var domain: Domain?
    var language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum Domain: String, Codable {
    case appsAppleCOM = "apps.apple.com"
    case epicgamesCOM = "epicgames.com"
    case gogCOM = "gog.com"
    case marketplaceXboxCOM = "marketplace.xbox.com"
    case microsoftCOM = "microsoft.com"
    case nintendoCOM = "nintendo.com"
    case playGoogleCOM = "play.google.com"
    case storePlaystationCOM = "store.playstation.com"
    case storeSteampoweredCOM = "store.steampowered.com"
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    var platform: EsrbRating?
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    var platform: PlatformPlatform?
    var releasedAt: String?
    var requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    var id: Int?
    var name, slug: String?
    var image, yearEnd: String?
    var yearStart: Int?
    var gamesCount: Int?
    var imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    var minimum, recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    var id: Int?
    var title: Title?
    var count: Int?
    var percent: Double?
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    var id: Int?
    var image: String?
}

// MARK: - Store
struct Store: Codable {
    var id: Int?
    var store: Genre?
}
