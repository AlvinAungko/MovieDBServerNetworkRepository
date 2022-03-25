//
//  MovieShowCaseViewController.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 19/03/2022.
//

import UIKit

class MovieShowCaseViewController: UIViewController {
    
  
    
    var currentPage:Int = 1
    var totalPages:Int = 1
    
    fileprivate let movieModelLayer = MovieModelLayer.movieModel
    
    var movieShowCaseFilms = Array<MixedMoviesAndSeriesList>()
    
    

    var movieShowCaseList:Array<MixedMoviesAndSeriesList>?
    {
        didSet
        {
            if let _ = movieShowCaseList
            {
                self.movieShowCaseFilms.append(contentsOf: movieShowCaseList ?? Array<MixedMoviesAndSeriesList>())
                self.movieShowCaseCollectionView.reloadData()
            }
        }
    }
    
    let networkAgent = NetworkingAgentAPI.shared
    
    deinit {
        debugPrint("The Movie show case is removed from the memory.")
    }
    
    @IBOutlet weak var movieShowCaseCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSourceAndDelegate()
        registerCells()
        fetchTopRateFilm(page:1)
        self.navigationItem.title = "Movie Showcase"
        // Do any additional setup after loading the view.
    }
    

}

extension MovieShowCaseViewController
{
    private func fetchTopRateFilm(page:Int)
    {
        movieModelLayer.fetchTheTopRatedMovie(page:page) { [weak self]
            topRatedMovie in
            
            guard let self = self else {return}
            
            switch topRatedMovie
            {
            case.sucess(let topRatedMovie):
                
                self.movieShowCaseList = self.returnTheArrayOfMixedMoviesAndSeries(topRatedFilm: topRatedMovie)
                
                self.currentPage = topRatedMovie.page ?? 0
                self.totalPages = topRatedMovie.totalPages ?? 0
                
            case.failure(let errorMessage): debugPrint(errorMessage)
                
            }
            
        }

    }
}

extension MovieShowCaseViewController
{
    private func registerCells()
    {
        movieShowCaseCollectionView.registerCollectionViewCells(cell: MovieShowCaseCollectionViewCell.identifier)
    }
    
    private func setDataSourceAndDelegate()
    {
        movieShowCaseCollectionView.dataSource = self
        movieShowCaseCollectionView.delegate = self
    }
}

extension MovieShowCaseViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieShowCaseFilms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = movieShowCaseCollectionView.bindCollectionCellsToYourCollectionView(cell: MovieShowCaseCollectionViewCell.identifier, indexPath: indexPath) as MovieShowCaseCollectionViewCell
        
        cell.topRatedFilm = movieShowCaseFilms[indexPath.row]
        
        cell.onTabFilm = { [weak self]
            movieID,typeOfTheFilm in
            
            guard let self = self else {return} // Checking whether the view controller is still on the memory.
            
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {return}
            
//            vc.modalTransitionStyle = .coverVertical
//            vc.modalPresentationStyle = .fullScreen
            
            vc.filmID = movieID
            vc.typeOfFilm = typeOfTheFilm
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = movieShowCaseCollectionView.bounds.width - 50
        let itemHeight = (itemWidth/16)*9
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        let isLastRow = (indexPath.row) == (movieShowCaseFilms.count - 1)
        let hasMorePaeges = currentPage < totalPages
        
        if isLastRow && hasMorePaeges
        {
            currentPage += 1
            
            self.fetchTopRateFilm(page:currentPage)
        }
        
        
    }
}

extension MovieShowCaseViewController
{
    private func returnTheArrayOfMixedMoviesAndSeries(topRatedFilm:TopRatingMovie)->Array<MixedMoviesAndSeriesList>
    {
        
        
        return topRatedFilm.results?.map({ topMovie -> MixedMoviesAndSeriesList in
           
           return MixedMoviesAndSeriesList(adult: topMovie.adult ?? false, video: topMovie.video ?? false, backdropPath: topMovie.backdropPath ?? "", firstAirDate: topMovie.releaseDate ?? "", genreID: topMovie.genreIDS ?? Array<Int>(), id: topMovie.id ?? 0, name: topMovie.title ?? "", originCountry: Array<String>() , originalLanguage: topMovie.originalLanguage ?? "", originalName: topMovie.originalTitle ?? "", overview: topMovie.overview ?? "", popularity: topMovie.popularity ?? 0.0, posterPath: topMovie.posterPath ?? "", voteAverage: topMovie.voteAverage ?? 0.0, voteCount: topMovie.voteCount ?? 0, typeOfTheFilm: .movies)
        }) ?? Array<MixedMoviesAndSeriesList>()
    }
}
