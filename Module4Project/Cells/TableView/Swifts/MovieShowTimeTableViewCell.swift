//
//  MovieShowTimeTableViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit

class MovieShowTimeTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var movieSeeMoreLabel: UILabel!
    
    @IBOutlet weak var movieBackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpRoundCorners()
        underlineWords()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieShowTimeTableViewCell{
    private func setUpRoundCorners()
    {
        movieBackView.layer.cornerRadius = 13.5
//        movieBackView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        movieBackView.clipsToBounds = true
       
    }
    
    private func underlineWords()
    {
        movieSeeMoreLabel.attributedText = movieSeeMoreLabel.returnAttributedString(text: "See More")
    }
}




