//
//  MovieModelLayer.swift
//  Module4Project
//
//  Created by Alvin  on 25/03/2022.
//

import Foundation

class MovieModelLayer:BaseNetworkAgent
{
    static let movieModel = MovieModelLayer()
}

extension MovieModelLayer:MovieProtocol
{
    func fetchUpComingMovieList(completion: @escaping (MDBResponse<UpcomingMovie>) -> Void) {
        networkAgent.fetchUpComingMovieList(completion: completion)
    }
    
    func fetchPopularMovie(completion: @escaping (MDBResponse<PopularMovieList>) -> Void) {
        networkAgent.fetchPopularMovie(completion: completion)
    }
    
    func fetchTheMovieDetail(movieID: Int, completion: @escaping (MDBResponse<MovieDetail>) -> Void) {
        networkAgent.fetchTheMovieDetail(movieID: movieID, completion: completion)
    }
    
    func fetchTheTopRatedMovie(page: Int, completion: @escaping (MDBResponse<TopRatingMovie>) -> Void) {
        networkAgent.fetchTheTopRatedMovie(page: page, completion: completion)
    }
    
    func fetchTheCreditsAccordingToTheMovieID(movieID: Int, completion: @escaping (MDBResponse<CreditDataModel>) -> Void) {
        networkAgent.fetchTheCreditsAccordingToTheMovieID(movieID: movieID, completion: completion)
    }
    
    func fetchTheMovieTrailers(moviesID: Int, completion: @escaping (MDBResponse<TVTrailer>) -> Void) {
        networkAgent.fetchTheMovieTrailers(moviesID: moviesID, completion: completion)
    }
    
    func searchTheMovie(movieName: String, page: Int, completion: @escaping (MDBResponse<UpcomingMovie>) -> Void) {
        networkAgent.searchTheMovie(movieName: movieName, page: page, completion: completion)
    }
    
    
}


