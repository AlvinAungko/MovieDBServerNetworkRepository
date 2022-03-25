//
//  NetworkProtocol.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 24/03/2022.
//

import Foundation


protocol NetworkingProtocol
{
    func fetchUpcomingMovie(completionHandler:@escaping(MovieDBServer<UpcomingMovie>)->Void)
}


enum MovieDBServer<T>
{
    case success(T)
    case failure(String)
}
