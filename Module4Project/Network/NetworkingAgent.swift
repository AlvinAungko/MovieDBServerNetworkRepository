//
//  NetworkingAgent.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 10/03/2022.
//

import Foundation
import Alamofire

// MARK: NetworkingAgentAPI.fetchUpComingMovieList >> If the func is declared as static

struct NetworkingAgentAPI:MovieDBNetworkProtocol
{
    static let shared = NetworkingAgentAPI()
    
    // MARK: fetch the upcoming movie list from the server
    
    func fetchUpComingMovieList(completion:@escaping(MDBResponse<UpcomingMovie>)->Void)
    {
//        let url = "\(AppConstants.baseUrl)/movie/upcoming?api_key=\(AppConstants.apiKey)"
        AF.request(MovieDBServerNetwork.upcomingMovie).responseDecodable(of:UpcomingMovie.self)
        {
            response in
            
            
            switch response.result
            {
            case.success(let upcomingMovie):
                
                let statusCode = response.response?.statusCode
                debugPrint(" Status Code in success >> \(statusCode ?? 0)")
                debugPrint("UpComingMovie >> \(upcomingMovie.page ?? 0)")
                completion(.sucess(upcomingMovie))
                
            case.failure(let error):
                let statusCode = response.response?.statusCode
                debugPrint(" Status Code in failure >> \(statusCode ?? 0)")
                completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: error)))
            }
            
        }
    }
    
    
    
    // MARK: fetch the popular movie from the server
    
    func fetchPopularMovie(completion:@escaping(MDBResponse<PopularMovieList>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/movie/popular?api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of: PopularMovieList.self ){
            response in
            
            switch response.result
            {
            case.success(let upcomingMovieFromServer):completion(.sucess(upcomingMovieFromServer))
            case.failure(let errorFromServer) : completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServer)))
            }
            
        }
    }
    
    // MARK: fetch popularSeries From The Server
    
    func fetchPopularSeries(completion:@escaping(MDBResponse<PopulaBestrSeries>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/tv/popular?api_key=\(AppConstants.apiKey)"
        AF.request(url).responseDecodable(of: PopulaBestrSeries.self ) {
            response in
            
            switch response.result
            {
            case.success(let popularBestSeries):completion(.sucess(popularBestSeries))
            case.failure(let errorMessage):completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorMessage)))
            }
            
        }
    }
    
    // MARK: fetch the genreList from the server
    
    func fetchGenresListForMovies(completion:@escaping(MDBResponse<GenresModel>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/genre/movie/list?api_key=\(AppConstants.apiKey)"
        AF.request(url).responseDecodable(of:GenresModel.self){
            response in
            
            switch response.result
            {
            case.success(let genreModel):completion(.sucess(genreModel))
            case.failure(let error):completion(.failure(error.localizedDescription))
            }
            
        }
    }
    
    // MARK: fetch the MovieDetail from the server
    
    func  fetchTheMovieDetail(movieID:Int,completion:@escaping(MDBResponse<MovieDetail>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/movie/\(movieID)?api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:MovieDetail.self){
            response in
            
            switch response.result
            {
            case.success(let movieDetail):completion(.sucess(movieDetail))
            case.failure(let errorMessage):completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorMessage)))
            }
            
        }
        
    }
    
    // MARK: fetch the SeriesDetail from the server
    
    func fetchTheSerieDetail(seriesID:Int,completion:@escaping(MDBResponse<SeriesDetail>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/tv/\(seriesID)?api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:SeriesDetail.self){
            respone in
            
            switch respone.result
            {
            case.success(let seriesDetail):completion(.sucess(seriesDetail))
            case.failure(let errorMessage):completion(.failure(handleError(respone, errorStorage: MDBErrorModel.self, totalError: errorMessage)))
                
            }
            
        }
        
    }
    
    // MARK: fetch the topRated Movie
    
    func fetchTheTopRatedMovie(page:Int,completion:@escaping(MDBResponse<TopRatingMovie>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/movie/top_rated?page=\(page)&api_key=\(AppConstants.apiKey)"
        AF.request(url).responseDecodable(of:TopRatingMovie.self){
            response in
            
            switch response.result
            {
            case.success(let topRatingMovie):
                completion(.sucess(topRatingMovie))
            case.failure(let error):
                completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: error)))
            }
            
        }
    }
    
    // MARK: fetch the Actors From the server
    
    func fetchTheActorList(page:Int,completion:@escaping(MDBResponse<ActorDataModel>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/person/popular?page=\(page)&api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:ActorDataModel.self) {
            response in
            
            switch response.result
            {
            case.success(let actorData):completion(.sucess(actorData))
            case.failure(let errorMessage):completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorMessage)))
            }
            
        }
        
    }
    
    // MARK: fetch the credits accoring to the movieID
    
    func fetchTheCreditsAccordingToTheMovieID(movieID:Int,completion:@escaping(MDBResponse<CreditDataModel>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/movie/\(movieID)/credits?api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:CreditDataModel.self){
            response in
            
            switch response.result
            {
            case.success(let movieCastList): completion(.sucess(movieCastList))
            case.failure(let errorFromServer): completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServer)))
            }
            
        }
        
    }
    
    // MARK: fetch the credits accoring to the seriesID
    
    func fetchTheCastAccordingToTheSeriesID(seriesID:Int,completion:@escaping(MDBResponse<CreditDataModel>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/tv/\(seriesID)/credits?api_key=\(AppConstants.apiKey)"
        AF.request(url).responseDecodable(of:CreditDataModel.self)
        {
            response in
            
            switch response.result
            {
            case.success(let seriesCasts):completion(.sucess(seriesCasts))
            case.failure(let errorFromServer):completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServer)))
            }
        }
    }
    
    // MARK: fetch the TvTrailers from the server
    
    func fetchTheTvTrailers(seriesID:Int,completion:@escaping(MDBResponse<TVTrailer>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/tv/\(seriesID)/videos?api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:TVTrailer.self){
            response in
            
            switch response.result
            {
            case.success(let tvTrailer):completion(.sucess(tvTrailer))
            case.failure(let errorFromServer):completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServer)))
            }
            
        }
        
    }
    
    // MARK: fetch the movieTrailers from the server
    
    func fetchTheMovieTrailers(moviesID:Int,completion:@escaping(MDBResponse<TVTrailer>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/movie/\(moviesID)/videos?api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:TVTrailer.self){
            response in
            
            switch response.result
            {
            case.success(let tvTrailer):completion(.sucess(tvTrailer))
            case.failure(let errorFromServer):completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServer)))
            }
            
        }
        
    }
    
    // MARK: fetch the detail of the actor
    
    func fetchTheDetailOfTheActor(actorID:Int,completion:@escaping(MDBResponse<ActorDetailDataModel>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/person/\(actorID)?api_key=\(AppConstants.apiKey)"
        AF.request(url).responseDecodable(of:ActorDetailDataModel.self) {
            response in
            
            switch response.result
            {
            case.success(let actorDetail): completion(.sucess(actorDetail))
            case.failure(let errorFromServr): completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServr)))
            }
        }
    }
    
    
    // MARK: fetch the list of combined movies which the actor Starred in
    
    func fetchTheListOfCombinedMoviesThatTheActorStaredIn(actorID:Int,completion:@escaping(MDBResponse<ActorCombinedMovie>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/person/\(actorID)/movie_credits?api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:ActorCombinedMovie.self){
            response in
            
            switch response.result
            {
            case.success(let actorMovie): completion(.sucess(actorMovie))
            case.failure(let errorFromServre): completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServre)))
            }
        }
    }
    
    // MARK: Search the movies according to the name
    
    func searchTheMovie(movieName:String,page:Int,completion:@escaping(MDBResponse<UpcomingMovie>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/search/movie?page=\(page)&query=\(movieName)&api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:UpcomingMovie.self)
        {
            response in
            switch response.result
            {
            case.success(let movieList):completion(.sucess(movieList))
            case.failure(let errorFromServer):completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServer)))
            }
        }
        
    }
    
    // MARK: Search the series accoring to the name
    
    func searchTheSeries(seriesName:String,page:Int,completion:@escaping(MDBResponse<PopulaBestrSeries>)->Void)
    {
        let url = "\(AppConstants.baseUrl)/search/tv?page=\(page)&query=\(seriesName)&api_key=\(AppConstants.apiKey)"
        
        AF.request(url).responseDecodable(of:PopulaBestrSeries.self)
        {
            response in
            switch response.result
            {
            case.success(let seriesList):completion(.sucess(seriesList))
            case.failure(let errorFromServer):completion(.failure(handleError(response, errorStorage: MDBErrorModel.self, totalError: errorFromServer)))
            }
        }
        
    }
    
    /*
        error can be presented in these typical orders
     
     1. JSON Serialization Error
     2. Wrong URL Path
     3. Incorrect Method
     4. Missing Credential
     5. 4xx
     6. 5xx
     
     
     Generally, we have to print these out in order to trace the error we commiitted.
     
     1. Checking Endpoint
     2. Checking StatusCode
     3. Checking ResponseBody
     4. Checking the error which manifests the incorrect data format which we used to store data from server
     
     */
    
    // MARK: Handle Error
    
    fileprivate func handleError<T , E: MDBError>(_ response: DataResponse<T,AFError>, errorStorage: E.Type, totalError:AFError ) -> String
    {
        
       // 1 - Check the endpoint
        
        let urlRequestThatImade = response.request?.url?.absoluteString ?? ""
        
       
       //2 - Check the Status Code
        
        let statusCode = response.response?.statusCode ?? 0
        
        
        //3 - Check the response Body
        
        guard let data = response.data else {return "No Data"}
        
        let responseBody = String(data: data , encoding: .utf8)
        
        
        // 4 - Print the Errors
        
        debugPrint("""
                
                1 >> URLEndPoint
                \(urlRequestThatImade)
                
                2 >> statusCode
                \(statusCode)
                
                3 >> responseBody
                \(responseBody ?? "")
                
                4 >> localizedDescription
                \(totalError.underlyingError!)
                
                5 >> underTLyingError
                \(totalError.errorDescription ?? "")

                """)
        
        // 5 - Storing the errors in the local xCode Storage
        
        let jsonDecoder = JSONDecoder()
        
        let errorBody =  try?jsonDecoder.decode(errorStorage, from: data)
        
        let errorMessage = errorBody?.errorMessage ?? ""
        
        return errorMessage 
    }
    
}

protocol MDBError:Decodable
{
    var errorMessage:String
    {
        get
    }
}

struct MDBErrorModel:MDBError
{
    var errorMessage:String
    {
        return message ?? ""
    }
    
    var message:String?
    var code:Int?
    var success:Bool
    
    enum CodingKeys:String,CodingKey
    {
        case message = "status_message"
        case code = "status_code"
        case success
    }
}

enum MDBResponse <T>
{
    case sucess(T)
    case failure(String)
}


