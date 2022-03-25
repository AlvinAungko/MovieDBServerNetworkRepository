//
//  CombinedMovieList.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 10/03/2022.
//

import Foundation

struct MovieList:Hashable
{
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
