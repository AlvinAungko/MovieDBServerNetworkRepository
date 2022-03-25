//
//  MixedSeriesAndMovieModel.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 14/03/2022.
//

import Foundation

struct MixedMoviesAndSeriesList:Hashable
{
    let adult:Bool?
    let video:Bool?
    let backdropPath:String?
    let firstAirDate:String?
    let genreID:[Int]?
    let id:Int?
    let name:String?
    let originCountry:[String]?
    let originalLanguage:String?
    let originalName:String?
    let overview:String?
    let popularity:Double?
    let posterPath:String?
    let voteAverage:Double?
    let voteCount:Int?
    let typeOfTheFilm:TypeOfTheFilm
    
}

enum TypeOfTheFilm:String
{
    case series = "Series is called"
    case movies = "Movie is called"
}
