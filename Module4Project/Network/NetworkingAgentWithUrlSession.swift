//
//  NetworkingAgentWithUrlSession.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 24/03/2022.
//

import Foundation

struct NetworkingAgentWithUrlSession:NetworkingProtocol
{
    func fetchUpcomingMovie(completionHandler:@escaping (MovieDBServer<UpcomingMovie>) -> Void) {
        
        guard let url = try? MovieDBServerNetwork.upcomingMovie.asURL() else {return}
        
        let urlSession = URLSession.shared
        
        let sessionDatTask =  urlSession.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                guard let response = response as? HTTPURLResponse else {return}
                
                let statusCode = response.statusCode
                let successCodeRange = 200..<299
                
                debugPrint(statusCode)
                
                if successCodeRange.contains(statusCode)
                {
                    guard let correctData = data else {
                        
                        debugPrint("The data is not returned")
                        return
                                }
                    
                guard let storedUpComingMovieData =  try?JSONDecoder().decode(UpcomingMovie.self, from: correctData) else {return}
                    
                    completionHandler(.success(storedUpComingMovieData))
                    
                } else {
                    
                    guard let errorData = data else  {
                        debugPrint("The error Data is not returned")
                        return
                        
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    
                    guard let errorStorage = try? jsonDecoder.decode(MDBErrorModel.self, from: errorData) else {
                        debugPrint("Error is not returned")
                        return
                        
                    }
                    
                    completionHandler(.failure(errorStorage.errorMessage))
                }
            }
            
        }
        
        sessionDatTask.resume()
    }
    
    static let shared = NetworkingAgentWithUrlSession()
}


