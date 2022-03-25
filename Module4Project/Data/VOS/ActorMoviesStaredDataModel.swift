//
//  ActorMoviesStaredDataModel.swift
//  Module4Project
//
//  Created by Alvin  on 19/03/2022.
//

import Foundation

// ActorCombinedMovie,ActorCast,ActorCrew


struct ActorCombinedMovie: Codable {
    let cast: [ActorCast]?
    let crew: [ActorCrew]?
    let id: Int?
}

// MARK: - Cast
struct ActorCast: Codable {
    let originalLanguage: String?
    let originalTitle: String?
    let posterPath: String?
    let video: Bool?
    let voteAverage: Double?
    let overview, releaseDate: String?
    let voteCount: Int?
    let title: String?
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let genreIDS: [Int]?
    let popularity: Double?
    let character, creditID: String?
    let order: Int?
    let mediaType: String?
    let firstAirDate, originalName: String?
    let originCountry: [String]?
    let name: String?
    let episodeCount: Int?

    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case title, adult
        case backdropPath = "backdrop_path"
        case id
        case genreIDS = "genre_ids"
        case popularity, character
        case creditID = "credit_id"
        case order
        case mediaType = "media_type"
        case firstAirDate = "first_air_date"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case name
        case episodeCount = "episode_count"
    }
}

//enum MediaType: String, Codable {
//    case movie = "movie"
//    case tv = "tv"
//}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//}

// MARK: - Crew
struct ActorCrew: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview, posterPath, releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let popularity: Double?
    let creditID, department, job: String?
    let mediaType: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case creditID = "credit_id"
        case department, job
        case mediaType = "media_type"
    }
}

