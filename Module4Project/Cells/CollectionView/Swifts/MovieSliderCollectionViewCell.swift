//
//  MovieSliderCollectionViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 08/02/2022.
//

import UIKit
import SDWebImage

class MovieSliderCollectionViewCell: UICollectionViewCell {

    var onTabUpcomingMovie:(Int,TypeOfTheFilm)->Void = { _,_ in}
    
    var upcomingMovie:MixedMoviesAndSeriesList?
    {
        didSet
        {
            if let data = upcomingMovie
            {
                self.movieTitle.text = data.originalName ?? ""
                movieSliderCollectionViewCellImage.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.backdropPath ?? "")"))
            }
        }
    }
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSliderCollectionViewCellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addGesture()
    }

}

extension MovieSliderCollectionViewCell
{
    private func addGesture()
    {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTabView))
        movieSliderCollectionViewCellImage.isUserInteractionEnabled = true
        movieSliderCollectionViewCellImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func onTabView()
    {
        onTabUpcomingMovie(self.upcomingMovie?.id ?? 0, self.upcomingMovie?.typeOfTheFilm ?? .series)
    }
}
