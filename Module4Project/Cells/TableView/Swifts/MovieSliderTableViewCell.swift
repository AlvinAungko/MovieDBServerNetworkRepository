//
//  MovieSliderTableViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit
import Alamofire


class MovieSliderTableViewCell: UITableViewCell {
    
    var upcomingMovieData:Array<MixedMoviesAndSeriesList>?
    {
        didSet{
            if let data = upcomingMovieData
            {
                self.movieSliderCollectionView.reloadData()
                pageControl.numberOfPages = data.count
            }
        }
    }
    
     var delegate:MovieItemDelegate?

    @IBOutlet weak var movieSliderCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerCells()
        setDataSourceAndDelegate()
        
       
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



extension MovieSliderTableViewCell
{
    private func registerCells()
    {
        movieSliderCollectionView.registerCollectionViewCells(cell: MovieSliderCollectionViewCell.identifier)
    }
    
    private func setDataSourceAndDelegate()
    {
        movieSliderCollectionView.dataSource = self
        movieSliderCollectionView.delegate = self
    }
}

extension MovieSliderTableViewCell:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return upcomingMovieData?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = movieSliderCollectionView.bindCollectionCellsToYourCollectionView(cell: MovieSliderCollectionViewCell.identifier, indexPath: indexPath) as MovieSliderCollectionViewCell
    
        guard let upcomingMovies = upcomingMovieData else {
            debugPrint("There is no upcoming Movie list.")
            return UICollectionViewCell()
        }
        
        cell.upcomingMovie = upcomingMovies[indexPath.row]
        cell.onTabUpcomingMovie = {
            
            id,TypeOfTheFilm in
            self.delegate?.onTabGenreMovieAndSeries(typeOfFilm: TypeOfTheFilm, filmID: id)
            
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: movieSliderCollectionView.frame.width, height: movieSliderCollectionView.frame.height)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onTabMovieSliderContent()
    }
    
    
}
