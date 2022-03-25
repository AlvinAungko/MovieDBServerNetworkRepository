//
//  GenreModelLayer.swift
//  Module4Project
//
//  Created by Alvin  on 25/03/2022.
//

import Foundation

class GenreModelLayer:BaseNetworkAgent
{
    static let genreModelLayer = GenreModelLayer()
}

extension GenreModelLayer:GenreProtocol
{
    func fetchGenresListForMovies(completion: @escaping (MDBResponse<GenresModel>) -> Void) {
        networkAgent.fetchGenresListForMovies(completion: completion)
    }
    
    
}
