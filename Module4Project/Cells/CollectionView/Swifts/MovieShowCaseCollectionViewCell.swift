//
//  MovieShowCaseCollectionViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit
import SDWebImage

class MovieShowCaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var onTabFilm:(Int,TypeOfTheFilm)->Void = {_,_ in}
    var topRatedFilm:MixedMoviesAndSeriesList?
    {
        didSet
        {
            if let data = topRatedFilm{
                movieShowCaseImage.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.backdropPath ?? "")"))
                movieOrignialTitle.text = data.originalName ?? ""
                releaseDateLabel.text = data.firstAirDate ?? ""
                
            }
        }
    }
    
    @IBOutlet weak var movieOrignialTitle: UILabel!
    @IBOutlet weak var entireViewOfShowCaseContent: UIView!
    @IBOutlet weak var movieShowCaseImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundCorners()
        addGesture()
    }

}

extension MovieShowCaseCollectionViewCell
{
    private func roundCorners()
    {
        entireViewOfShowCaseContent.layer.cornerRadius = 13.5
        entireViewOfShowCaseContent.clipsToBounds = true
    }
}

extension MovieShowCaseCollectionViewCell
{
    private func addGesture()
    {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTab))
        entireViewOfShowCaseContent.isUserInteractionEnabled = true
        entireViewOfShowCaseContent.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func onTab()
    {
        onTabFilm(topRatedFilm?.id ?? 0, topRatedFilm?.typeOfTheFilm ?? .series)
    }
}
