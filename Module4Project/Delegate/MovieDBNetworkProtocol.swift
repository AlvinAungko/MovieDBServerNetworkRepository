//
//  MovieDBNetworkProtocol.swift
//  Module4Project
//
//  Created by Alvin  on 25/03/2022.
//

import Foundation

// MARK: Declaring Movie Protocol

protocol MovieProtocol
{
    func fetchUpComingMovieList(completion:@escaping(MDBResponse<UpcomingMovie>)->Void)
    
    func fetchPopularMovie(completion:@escaping(MDBResponse<PopularMovieList>)->Void)
    
    func  fetchTheMovieDetail(movieID:Int,completion:@escaping(MDBResponse<MovieDetail>)->Void)
    
    func fetchTheTopRatedMovie(page:Int,completion:@escaping(MDBResponse<TopRatingMovie>)->Void)
    
    func fetchTheCreditsAccordingToTheMovieID(movieID:Int,completion:@escaping(MDBResponse<CreditDataModel>)->Void)
    
    func fetchTheMovieTrailers(moviesID:Int,completion:@escaping(MDBResponse<TVTrailer>)->Void)
    
    func searchTheMovie(movieName:String,page:Int,completion:@escaping(MDBResponse<UpcomingMovie>)->Void)
    
    
}

// MARK: Delcare Series Protocol

protocol SeriesProtocol
{
    
    func fetchPopularSeries(completion:@escaping(MDBResponse<PopulaBestrSeries>)->Void)
    
    func fetchTheSerieDetail(seriesID:Int,completion:@escaping(MDBResponse<SeriesDetail>)->Void)
    
    func fetchTheCastAccordingToTheSeriesID(seriesID:Int,completion:@escaping(MDBResponse<CreditDataModel>)->Void)
    
    func fetchTheTvTrailers(seriesID:Int,completion:@escaping(MDBResponse<TVTrailer>)->Void)
    
    func searchTheSeries(seriesName:String,page:Int,completion:@escaping(MDBResponse<PopulaBestrSeries>)->Void)
}

// MARK: Delcaring Actor Protocol

protocol ActorProtocol
{
    func fetchTheActorList(page:Int,completion:@escaping(MDBResponse<ActorDataModel>)->Void)
    
    func fetchTheDetailOfTheActor(actorID:Int,completion:@escaping(MDBResponse<ActorDetailDataModel>)->Void)
    
    func fetchTheListOfCombinedMoviesThatTheActorStaredIn(actorID:Int,completion:@escaping(MDBResponse<ActorCombinedMovie>)->Void)
}

// MARK: Declaring Genre Protocol

protocol GenreProtocol
{
    func fetchGenresListForMovies(completion:@escaping(MDBResponse<GenresModel>)->Void)
}

// MARK: Declaring All Network Protocol

protocol MovieDBNetworkProtocol
{
    func fetchUpComingMovieList(completion:@escaping(MDBResponse<UpcomingMovie>)->Void)
    
    func fetchPopularMovie(completion:@escaping(MDBResponse<PopularMovieList>)->Void)
    
    func fetchPopularSeries(completion:@escaping(MDBResponse<PopulaBestrSeries>)->Void)
    
    func fetchGenresListForMovies(completion:@escaping(MDBResponse<GenresModel>)->Void)
    
    func  fetchTheMovieDetail(movieID:Int,completion:@escaping(MDBResponse<MovieDetail>)->Void)
    
    func fetchTheSerieDetail(seriesID:Int,completion:@escaping(MDBResponse<SeriesDetail>)->Void)
    
    func fetchTheTopRatedMovie(page:Int,completion:@escaping(MDBResponse<TopRatingMovie>)->Void)
    
    func fetchTheActorList(page:Int,completion:@escaping(MDBResponse<ActorDataModel>)->Void)
    
    func fetchTheCreditsAccordingToTheMovieID(movieID:Int,completion:@escaping(MDBResponse<CreditDataModel>)->Void)
    
    func fetchTheCastAccordingToTheSeriesID(seriesID:Int,completion:@escaping(MDBResponse<CreditDataModel>)->Void)
    
    func fetchTheTvTrailers(seriesID:Int,completion:@escaping(MDBResponse<TVTrailer>)->Void)
    
    func fetchTheMovieTrailers(moviesID:Int,completion:@escaping(MDBResponse<TVTrailer>)->Void)
    
    func fetchTheDetailOfTheActor(actorID:Int,completion:@escaping(MDBResponse<ActorDetailDataModel>)->Void)
    
    func fetchTheListOfCombinedMoviesThatTheActorStaredIn(actorID:Int,completion:@escaping(MDBResponse<ActorCombinedMovie>)->Void)
    
    func searchTheMovie(movieName:String,page:Int,completion:@escaping(MDBResponse<UpcomingMovie>)->Void)
    
    func searchTheSeries(seriesName:String,page:Int,completion:@escaping(MDBResponse<PopulaBestrSeries>)->Void)
}
