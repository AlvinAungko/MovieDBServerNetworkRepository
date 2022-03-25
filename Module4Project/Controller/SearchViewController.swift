//
//  SearchViewController.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 19/03/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var dataEntryTextField: UITextField!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var searchMovieCollectionView: UICollectionView!
    
   private let searchBar = UISearchBar()
    
    fileprivate let movieModelLayer = MovieModelLayer.movieModel
    
    fileprivate let seriesModelLayer = SeriesModelLayer.seriesModelLayer
    
    var currentPage:Int = 1
    var totalPages:Int = 1
    
    let networkAgent = NetworkingAgentAPI.shared
    
    // MARK: It is in this variable where the data seems to be consistent throughout the networkcalls as this variable stores a list of data received from every networkcall and presents it to the user.
    
    var mixedFilms = Array<MixedMoviesAndSeriesList>()
    
    // MARK: In this variable, the data doesn't seem to be consistent as it changes everytime a new network call is carried out, but once it captures the value from the network call, it appends it to the mixedFilm Array.
    
    
    var mixedMovies:Array<MixedMoviesAndSeriesList>?
    {
        didSet{
            if let data = mixedMovies
            {
                self.mixedFilms.append(contentsOf: data)
                self.searchMovieCollectionView.reloadData()
                
            }
        }
    }
    
    // MARK: In this variable, the data doesn't seem to be consistent as it changes everytime a new network call is carried out, but once it captures the value from the network call, it appends it to the mixedFilm Array.
    
    var mixedSeries:Array<MixedMoviesAndSeriesList>?
    {
        didSet
        {
            if let data = mixedSeries
            {
                self.mixedFilms.append(contentsOf: data)
                self.searchMovieCollectionView.reloadData()
            }
        }
    }
    
    deinit {
        debugPrint("The Search View is removed from the memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()
        setUpTheNavigationBar()
//        addGesture()
        setDataSourceAndDelegate()
        registerCells()
        searchTheMovie(movieName: "Avengers",page: currentPage)

        
            
        // Do any additional setup after loading the view.
    }
    

}

extension SearchViewController
{
    private func initSearchBar()
    {
        
        searchBar.placeholder = "Search The Film"
        searchBar.searchTextField.textColor = UIColor.white
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.topItem?.title = ""
        
    }

}

extension SearchViewController
{
    private func setUpTheNavigationBar()
    {
        guard let navigationController = self.navigationController else {
            debugPrint("No navigation controller")
            return 
            
        }
        
        let navigationBar = navigationController.navigationBar
        navigationBar.tintColor = .white
//        navigationBar.largeContentTitle = "Search"
        
        self.navigationItem.title = "Search"
        
    }
}

extension SearchViewController
{

    
    
    private func searchTheMovie(movieName:String,page:Int)
    {
       
        movieModelLayer.searchTheMovie(movieName: movieName,page: page) { [weak self] movieList in
            
            guard let self = self else {return}
            
            switch movieList
            {
            case.sucess(let movieList):
                
                self.currentPage = movieList.page ?? 0
                self.totalPages = movieList.totalPages ?? 0
                
                self.mixedMovies =
                movieList.results?.map({ movie -> MixedMoviesAndSeriesList in
                    
                    
                    
                    return MixedMoviesAndSeriesList(adult: movie.adult ?? false, video: movie.video ?? false, backdropPath: movie.backdropPath ?? "", firstAirDate: movie.releaseDate ?? "", genreID: movie.genreIDS ?? Array<Int>(), id: movie.id, name: movie.title ?? "", originCountry: Array<String>(), originalLanguage: movie.originalLanguage ?? "''", originalName: movie.originalTitle ?? "", overview: movie.overview, popularity: movie.popularity ?? 0.0, posterPath: movie.posterPath ?? "", voteAverage: movie.voteAverage ?? 0.0, voteCount: movie.voteCount ?? 0, typeOfTheFilm: .movies)
                })
                
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
            
                
        }
        
        seriesModelLayer.searchTheSeries(seriesName: movieName,page: page) { [weak self] movieList in
            
            guard let self = self else{return}
            
            switch movieList
            {
            case.sucess(let movieList): self.mixedSeries =
                movieList.results?.map({ movie -> MixedMoviesAndSeriesList in
                    
                    
                    
                    return MixedMoviesAndSeriesList(adult:false, video:  false, backdropPath: movie.backdropPath ?? "", firstAirDate: movie.firstAirDate ?? "", genreID: movie.genreIDS ?? Array<Int>(), id: movie.id, name: movie.name ?? "", originCountry: Array<String>(), originalLanguage: movie.originalLanguage ?? "''", originalName: movie.originalName ?? "", overview: movie.overview, popularity: movie.popularity ?? 0.0, posterPath: movie.posterPath ?? "", voteAverage: movie.voteAverage ?? 0.0, voteCount: movie.voteCount ?? 0, typeOfTheFilm: .series)
                })
                
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
           
                
        }
        
        

    }
    
//    private func addGesture()
//    {
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTabSearch))
//
//        searchImageView.addGestureRecognizer(tapGestureRecognizer)
//        searchImageView.isUserInteractionEnabled = true
//
//    }
    
//    @objc func onTabSearch()
//    {
//
////        debugPrint("On Tabbed")
//
//
//
////        debugPrint(actualText)
//
//        self.searchTheMovie(movieName: actualText,page:1)
//
//    }
    
    
    private func setDataSourceAndDelegate()
    {
        searchMovieCollectionView.dataSource = self
        searchMovieCollectionView.delegate = self
    }
    
    private func registerCells()
    {
        searchMovieCollectionView.registerCollectionViewCells(cell: BestFilmCollectionViewCell.identifier)
    }
}

extension SearchViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mixedFilms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = searchMovieCollectionView.bindCollectionCellsToYourCollectionView(cell: BestFilmCollectionViewCell.identifier, indexPath: indexPath) as BestFilmCollectionViewCell
        
        cell.mixedMovieAndSeries = mixedFilms[indexPath.row]
        
        cell.onTabFilm = { [weak self]
            filmID,typeOfTheFilm in
            
            guard let self = self else {return}
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {return}
            
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            
            vc.filmID = filmID
            vc.typeOfFilm = typeOfTheFilm
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let displayText = searchBar.text ?? ""
        
        let isLastRow = (indexPath.row) == (mixedFilms.count - 1)
        let hasMorePages = currentPage <= totalPages
        
        // MARK: This network call is poorly optimized because the network call depends on the pages available in the movie server. So in some cases, the pages of the movie might run out, however, there might be some available pages in series where we can extract data. But since this network call entirely depends on the pages available in the movie server
        
        //MARK: The best way to solve this issue is to compare the total pages of two network calls and assign the bigger one to a new variable and the network call can be adjusted to depend on that newly created variable.
        
        
        
        if isLastRow && hasMorePages
        {
            currentPage += 1
            searchTheMovie(movieName: displayText, page: currentPage)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: searchMovieCollectionView.bounds.width/2.3, height: 375)
    }
    
}

// MARK: when the search is made, all of the data from the list is removed and a new network call has been conducted.

extension SearchViewController:UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.mixedFilms.removeAll()
        self.currentPage = 1
        self.totalPages = 1
        
        let movieTextEntry = searchBar.text ?? "No Data"
        debugPrint(movieTextEntry)
        
        // MARK: Configuring the movieName for url to recognzie space character as %20
        
        let actualText:String = movieTextEntry.map { text -> String in
            if text == " "
            {
                return "%20"
            }
               
              else
            {
                return "\(text)"
            }
        }.reduce(String()) { partialResult, value2 in
            return "\(partialResult)\(value2)"
        }
        
        searchTheMovie(movieName: actualText, page: currentPage)
        
    }
}
