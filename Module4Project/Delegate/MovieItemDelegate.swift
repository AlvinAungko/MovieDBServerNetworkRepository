//
//  MovieItemDelegate.swift
//  Module4Project
//
//  Created by Alvin  on 12/02/2022.
//

import Foundation

protocol MovieItemDelegate
{
    func onTabMovieSliderContent()
    
    func onTabGenreMovieAndSeries(typeOfFilm:TypeOfTheFilm,filmID:Int)
    
    func onTabMoreActors()
    
    func onTabActor(actorID:Int)
    
    func onTabMovieShowCase()
}
