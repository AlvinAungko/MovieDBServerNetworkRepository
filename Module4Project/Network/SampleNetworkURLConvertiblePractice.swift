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
    
    // 1. Speficify a scheme and host
    
    var baseURL:String
    {
        return AppConstants.baseUrl
    }
    
    // 2. Specify a path
    
    var apiPath:String
    {
        switch self {
        case .upcomingMovie:
            return "/movie/upcoming"
        }
    }
    
    // 3. add a final piece which is query item to build a complete url
    
    var url:URL
    {
        let urlComponent = NSURLComponents(string: baseURL.appending(apiPath)) // Scheme, host, and apiPath is already specifed in this line
        
        if (urlComponent?.queryItems == nil)
        {
            urlComponent?.queryItems = []
        }
        
        // this is to check the presence of query items inside the url, if only the api_path is found, it sets the empty query item array to which new items can be appended
        
        urlComponent?.queryItems?.append(URLQueryItem(name: "api_key", value: AppConstants.apiKey))
        
       return urlComponent!.url!
        
    }
    
    func asURL() throws -> URL {
       return url
    }
    
    
}
