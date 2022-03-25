//
//  DummyModel.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import Foundation

class DummyGenreLabel
{
    var labelText:String
    var viewToHide:Bool
    
    init(text label:String,hideorNot view:Bool)
    {
        self.labelText = label
        self.viewToHide = view
    }
}
