//
//  GenreDataModel.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 10/03/2022.
//

import Foundation

struct GenresModel:Codable
{
    let genres:[GenresType]?
    
    enum CodingKeys:String,CodingKey
    {
        case genres = "genres"
    }
}

struct GenresType:Codable
{
    let id:Int?
    let name:String?
    
    enum CodingKeys:String,CodingKey
    {
        case id,name
    }
}
