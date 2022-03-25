//
//  SampleNetworkURLConvertiblePractice.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 23/03/2022.
//

import Foundation
import Alamofire

enum MovieDBServerNetwork:URLConvertible
{
   
    case upcomingMovie
    case popularMovie
    case popularSeries
    case genreList
    case movieDetail(_ movieID:Int)
    case seriesDetail(_ seriesID:Int)
    case topRatedMovie (_ page:Int)
    case actorsList(_ page:Int)
    case creditsMovieID(_ movieID:Int)
    case creditsSeriesID (_ seriesID:Int)
    case tvTrailers(_ seriesID:Int)
    case movieTrailers(_ movieID:Int)
    case detailOfTheActor(_ actorID:Int)
    case combinedMovies(_ actorID:Int)
    case searchMovie(_ movieName:String, _ page:Int)
    case searchSeries(_ seriesName:String, _ page:Int)
    
    
    
    // MARK: 1. Speficify a scheme and host
    
    var baseURL:String
    {
        return AppConstants.baseUrl
    }
    
    // MARK: 2. Specify a path
    
    var apiPath:String
    {
        switch self {
        case .upcomingMovie:
            return "/movie/upcoming"
        case .popularMovie:
            return "/movie/popular"
        case .popularSeries:
            return "/tv/popular"
        case .genreList:
            return "/genre/movie/list"
        case .movieDetail(let movieID):
            return "/movie/\(movieID)"
        case .seriesDetail(let seriesID):
            return "/tv/\(seriesID)"
        case .topRatedMovie(let page):
            return "/movie/top_rated?page=\(page)"
        case .actorsList(let page):
            return "/person/popular?page=\(page)"
        case .creditsMovieID( let movieID):
            return "/movie/\(movieID)/credits"
        case .creditsSeriesID(let seriesID):
            return "/tv/\(seriesID)/credits"
        case .tvTrailers(let seriesID):
            return "/tv/\(seriesID)/videos"
        case .movieTrailers(let movieID):
            return "/movie/\(movieID)/videos"
        case .detailOfTheActor(let actorID):
            return "/person/\(actorID)"
        case .combinedMovies(let actorID):
            return "/person/\(actorID)/movie_credits"
        case .searchMovie(let movieName, let page):
            return "/search/movie?page=\(page)&query=\(movieName)"
        case .searchSeries(let seriesName, let page):
            return "/search/tv?page=\(page)&query=\(seriesName)"
        }
    }
    
    // MARK: 3. add a final piece which is query item to build a complete url
    
    var url:URL
    {
        let urlComponent = NSURLComponents(string: baseURL.appending(apiPath)) // Scheme, host, and apiPath is already specifed in this line
        
        if (urlComponent?.queryItems == nil)
        {
            urlComponent?.queryItems = []
        }
        
        //MARK: this is to check the presence of query items inside the url, if only the api_path is found, it sets the empty query item array to which new items can be appended
        
        urlComponent?.queryItems?.append(URLQueryItem(name: "api_key", value: AppConstants.apiKey))
        
       return urlComponent!.url!
        
    }
    
    func asURL() throws -> URL {
       return url
    }
    
    
}
