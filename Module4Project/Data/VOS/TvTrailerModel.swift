//
//  TvTrailerModel.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 18/03/2022.
//

import Foundation

struct TVTrailer:Codable
{
    let id:Int?
    let results:Array<Trailer>?
    
    enum codingKeys:String,CodingKey
    {
        case id,results
    }
    
}

struct Trailer:Codable
{
    let iso639:String?
    let iso326:String?
    let name:String?
    let key:String?
    let publishedAt:String?
    let site:String?
    let size:Int?
    let type:String?
    let official:Bool?
    let id:String?
    
    enum codingKeys:String,CodingKey
    {
        case name,key,site,size,type,official,id
        case iso639 = "iso_639_1"
        case iso326 = "iso_3166_1"
        case publishedAt = "published_at"
    }
    
}
