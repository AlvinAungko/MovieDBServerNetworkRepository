//
//  ActorDetailDataModel.swift
//  Module4Project
//
//  Created by Alvin  on 19/03/2022.
//

import Foundation

struct ActorDetailDataModel: Codable {
    let adult: Bool?
    let alsoKnownAs: [String]?
    let biography, birthday: String?
//    let deathday: JSONNull?
    let gender: Int?
    let homepage: String?
    let id: Int?
    let imdbID, knownForDepartment, name, placeOfBirth: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, gender, homepage, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
}
