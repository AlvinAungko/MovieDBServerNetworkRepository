//
//  GenreMappingModel.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 10/03/2022.
//

import Foundation

class GenreList
{
    var id:Int
    var name:String
    var isSelected:Bool
    
    init(id:Int,name:String,isSelected:Bool)
    {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}
