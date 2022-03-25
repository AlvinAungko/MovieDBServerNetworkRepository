//
//  BestFilmCollectionViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit
import SDWebImage

class BestFilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var popularMovieRating: RatingControlStackView!
    @IBOutlet weak var popularMovieLabel: UILabel!
    
    
    
    var onTabFilm:(Int,TypeOfTheFilm)->Void = {_,_ in }
    
    var mixedMovieAndSeries:MixedMoviesAndSeriesList?
    {
        didSet
        {
            if let data = mixedMovieAndSeries
            {
                let voteStarCount:Int = Int((data.voteAverage ?? 0)/2)
                
                popularMovieRating.rating = voteStarCount
                
                popularMovieRatingLabel.text = String(data.voteAverage ?? 0.0)
                popularMovieLabel.text = data.originalName ?? ""
                imageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.backdropPath ?? "")"))
            }
        }
    }
    
    // CombinedMovie
    
    var combinedMovie:MovieList?
    {
        didSet
        {
            if let data = combinedMovie
            {
                let voteStarCount:Int = Int((data.voteAverage ?? 0)/2)
                
                popularMovieRating.rating = voteStarCount
                
                popularMovieRatingLabel.text = String(data.voteAverage ?? 0.0)
                popularMovieLabel.text = data.originalTitle ?? ""
                imageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.backdropPath ?? "")"))
            }
        }
    }
    
    
    // Series
    
//    var series:MixedMoviesAndSeriesList?
//    {
//        didSet
//        {
//            if let data = series
//            {
//                let voteStarCount:Int = Int((data.voteAverage ?? 0)/2)
//                
//                popularMovieRating.rating = voteStarCount
//                
//                popularMovieRatingLabel.text = String(data.voteAverage ?? 0.0)
//                popularMovieLabel.text = data.originalName ?? ""
//                imageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.backdropPath ?? "")"))
//            }
//        }
//    }
    
    
    @IBOutlet weak var popularMovieRatingLabel: UILabel!
    
    // PopularMovie
    
//    var popularMovie:PopularMovie?
//    {
//        didSet
//        {
//            if let data = popularMovie
//            {
//                let voteStarCount:Int = Int((data.voteAverage ?? 0)/2)
//
//                popularMovieRating.rating = voteStarCount
//
//                popularMovieRatingLabel.text = String(data.voteAverage ?? 0.0)
//                popularMovieLabel.text = data.originalTitle ?? ""
//                imageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.backdropPath ?? "")"))
//            }
//        }
//    }
    
    
    // actorMovies
    
    var actorCastMovie:ActorCast?
    {
        didSet
        {
            if let data = actorCastMovie
            {
                let voteStarCount:Int = Int((data.voteAverage ?? 0)/2)
                
                popularMovieRating.rating = voteStarCount
                
                popularMovieRatingLabel.text = String(data.voteAverage ?? 0.0)
                popularMovieLabel.text = data.originalTitle ?? data.originalName
                imageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.posterPath ?? data.backdropPath ?? "")"))
            }
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bestSeriesContentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupRoundAndCorner()
        addGestureRecognizerForFilm()
    }

}

extension BestFilmCollectionViewCell
{
    private func setupRoundAndCorner()
    {
        imageView.layer.cornerRadius = 11
        imageView.clipsToBounds = true
        
    }
}

extension BestFilmCollectionViewCell
{
    private func addGestureRecognizerForFilm()
    {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTabMovieOrSeries))
        
        imageView.addGestureRecognizer(gestureRecognizer)
        imageView.isUserInteractionEnabled = true
        
        
    }
    
    @objc func onTabMovieOrSeries()
    {
        onTabFilm(mixedMovieAndSeries?.id ?? 0,mixedMovieAndSeries?.typeOfTheFilm ?? .series)
    }
}
