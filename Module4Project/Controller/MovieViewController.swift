//
//  MovieViewController.swift
//  Module4Project
//
//  Created by Alvin  on 08/02/2022.
//

import UIKit

class MovieViewController: UIViewController,ActorDelegate {
    
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    
    func onTabFullTabBar(isOnTabbedFullBookMark: String) {
        debugPrint(isOnTabbedFullBookMark)
    }
    
    fileprivate let movieModelLayer = MovieModelLayer.movieModel
    
    fileprivate let seriesModelLayer = SeriesModelLayer.seriesModelLayer
    
    fileprivate let genreModelLayer = GenreModelLayer.genreModelLayer
    
    fileprivate let actorModelLayer = ActorModelLayer.actorModelLayer
    
    let sessionDBAgent = NetworkingAgentWithUrlSession.shared
    
    let movieDBAgent = NetworkingAgentAPI.shared
    
    // Upcoming Movie Data
    
    var upcomingMovieFromServer:UpcomingMovie?
    {
        didSet{
            if let _ = upcomingMovieFromServer
            {
                self.movieTableView.reloadSections(IndexSet(integer: Constants.movieShowCaseTableViewCell.rawValue), with: .automatic)
            }
        }
    }
    
    // Popular Movie Data
    
    var popularMovieDataFromServer:PopularMovieList?
    {
        didSet
        {
            if let _ = popularMovieDataFromServer
            {
                self.movieTableView.reloadSections(IndexSet(integer: Constants.bestPopularSeriesTableViewCell.rawValue), with: .automatic)
            }
        }
    }
    
    // Series Data
    
    var seriesDataFromServer : PopulaBestrSeries?
    {
        didSet
        {
            if let _ = seriesDataFromServer
            {
                self.movieTableView.reloadSections(IndexSet(integer: Constants.bestSeriesTableViewCell.rawValue), with: .automatic)
            }
                
        }
    }
    
    // Genres Data
    
    var genreList:[GenresType]?{
        didSet
        {
            if let _ = genreList
            {
                movieTableView.reloadSections(IndexSet(integer: Constants.genreLableTableViewCell.rawValue), with: .automatic)
            }
        }
    }
    
    var topRatedMovie:TopRatingMovie?
    {
        didSet
        {
            if let _ = topRatedMovie
            {
                self.movieTableView.reloadSections(IndexSet(integer: Constants.movieShowCaseTableViewCell.rawValue), with: .automatic)
            }
        }
    }
    
    var actorReceivedFromTheServer:ActorDataModel?
    {
        didSet
        {
            if let _ = actorReceivedFromTheServer
            {
                self.movieTableView.reloadSections(IndexSet(integer: Constants.bestActorTableViewCell.rawValue), with: .automatic)
            }
        }
    }
    
    // Genre CombinedMovieList
    
    var movieCombinedList = Array<MovieList>()
    
    var mixedMovieAndSeriesList = Array<MixedMoviesAndSeriesList>()
    
    
    @IBOutlet weak var ivSearch: UIImageView!
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var viewForToolBar: UIView!
    @IBOutlet weak var movieTableView: UITableView!
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        addGesture()
        setDataSourceAndDelegate()
        registerCells()
        fetchTheMovieList()
        fetchTheSeriesList()
        fetchThePopularMovieList()
        fetchTheGenreMovieList()
        fetchTheTopRatedMovies()
        fetchTheActorFromTheServer()
        // Do any additional setup after loading the view.
    }
    @IBAction func onTabSearch(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {return}
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
//        present(vc, animated: true, completion: nil)
    }
}

extension MovieViewController
{
    private func addGesture()
    {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTabSearch))
////        ivSearch.isUserInteractionEnabled = true
////        ivSearch.addGestureRecognizer(tapGesture)
        ///
    }
    
    @objc func onTabSearchButton()
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {return}
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .formSheet
        
        present(vc, animated: true, completion: nil)
    }
}

extension MovieViewController
{
    private func fetchTheMovieList()
    {
        movieModelLayer.fetchUpComingMovieList { [weak self] data in

            guard let self = self else {return}

           switch data
            {
           case.sucess(let upcomingMovie):self.upcomingMovieFromServer = upcomingMovie
           case.failure(let errorMessage):debugPrint(errorMessage)
           }
            
        }
        
//        sessionDBAgent.fetchUpcomingMovie { data in
//            switch data
//            {
//            case.success(let upcomingMovie):self.upcomingMovieFromServer = upcomingMovie
//            case.failure(let errorMessage):debugPrint("Error >> \(errorMessage)")
//            }
//        }

    }
    
    private func fetchThePopularMovieList()
    {
        movieModelLayer.fetchPopularMovie { [weak self] popularMovieData in
            
            guard let self = self else {return}
            
            switch popularMovieData
            {
            case.sucess(let popularMovieData):self.popularMovieDataFromServer = popularMovieData
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
            
        }

    }
    
    private func fetchTheSeriesList()
    {
        seriesModelLayer.fetchPopularSeries { [weak self] series in
            guard let self = self else {return}
            
            switch series
            {
            case.sucess(let series):self.seriesDataFromServer = series
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
            
        }

    }
    
    
    /*
     
        Presenting movies by category to the user.
     
        1. First, we fetch the genres values from the server and bind it to our view
        2. We make closures to capture the genre value that the user tapped.
        3. Once we get the genre value, we extract the movie list which is releated to that genre value(iD) from our dictionary.
        4. After the movie list is extracted, we present that list to the user.
     
     */
    
    private func fetchTheGenreMovieList()
    {
        genreModelLayer.fetchGenresListForMovies { [weak self] genreData in
            
            guard let self = self else { return }
            
            switch genreData
            {
            case.sucess(let genreData): self.genreList = genreData.genres
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
           
        }

    }
    
    private func fetchTheTopRatedMovies()
    {
        movieModelLayer.fetchTheTopRatedMovie(page:1) { [weak self] topRatedMovie in
            
            guard let self = self else { return }
            
           switch topRatedMovie
            {
           case.sucess(let topRatedMovie):self.topRatedMovie = topRatedMovie
           case.failure(let errorMessage):debugPrint(errorMessage)
           }
        }

    }
    
    private func fetchTheActorFromTheServer()
    {
        actorModelLayer.fetchTheActorList(page:1){ [weak self] ActorData in
            
            guard let self = self else { return }
            
            switch ActorData
            {
            case.sucess(let ActorData):self.actorReceivedFromTheServer = ActorData
            case.failure(let errorMessage):debugPrint(errorMessage)
                
            }
            
            
        }

    }
    
}


extension MovieViewController
{
    
    private func setDataSourceAndDelegate()
    {
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    private func registerCells()
    {
        movieTableView.registerTableViewCells(cell: MovieSliderTableViewCell.identifier)
        movieTableView.registerTableViewCells(cell: BestPopularFilmTableViewCell.identifier)
        movieTableView.registerTableViewCells(cell: MovieShowTimeTableViewCell.identifier)
        movieTableView.registerTableViewCells(cell: GenreLabelTableViewCell.identifier)
        movieTableView.registerTableViewCells(cell: MovieShowCaseTableViewCell.identifier)
        movieTableView.registerTableViewCells(cell: BestActorTableViewCell.identifier)
    }
    
}

extension MovieViewController:UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case Constants.movieSliderTableViewCell.rawValue:
            let cell = movieTableView.bindTableViewCellsToYourTableView(cell: MovieSliderTableViewCell.identifier, indexPath: indexPath) as MovieSliderTableViewCell
            
            cell.upcomingMovieData = returnTheMovieList()
            cell.delegate = self
            
            return cell
            
        case Constants.bestSeriesTableViewCell.rawValue:
            let cell = movieTableView.bindTableViewCellsToYourTableView(cell: BestPopularFilmTableViewCell.identifier, indexPath: indexPath) as BestPopularFilmTableViewCell
            
            cell.dataForBothMoviesAndSeries = returnThePopularMovieList()
            cell.delegate = self
            return cell
            
        case Constants.bestPopularSeriesTableViewCell.rawValue:
            let seriesTableViewCell = movieTableView.bindTableViewCellsToYourTableView(cell: BestPopularFilmTableViewCell.identifier, indexPath: indexPath) as BestPopularFilmTableViewCell
            
            seriesTableViewCell.dataForBothMoviesAndSeries = returnTheSeriesList()
            seriesTableViewCell.delegate = self
            return seriesTableViewCell
            
        case Constants.movieShowTimeCell.rawValue:
            let cell = movieTableView.bindTableViewCellsToYourTableView(cell: MovieShowTimeTableViewCell.identifier, indexPath: indexPath)
            
            return cell
        case Constants.genreLableTableViewCell.rawValue:
            let cell = movieTableView.bindTableViewCellsToYourTableView(cell: GenreLabelTableViewCell.identifier, indexPath: indexPath) as GenreLabelTableViewCell
            
            let genreTitleList = genreList?.map({ genreType -> GenreList in
                GenreList(id: genreType.id ?? 0, name: genreType.name ?? "", isSelected: false)
            })
            
            
            mixedMovieAndSeriesList.append(contentsOf: returnTheMovieList())
            mixedMovieAndSeriesList.append(contentsOf: returnTheSeriesList())
            
            
            cell.onTabMovieAndSeriesDelegate = self
            cell.mixedMovieAndSeriesList = mixedMovieAndSeriesList
            
            genreTitleList?.first?.isSelected = true
            
            cell.genreList = genreTitleList
            
            return cell
            
            
        case Constants.movieShowCaseTableViewCell.rawValue:
            let cell = movieTableView.bindTableViewCellsToYourTableView(cell: MovieShowCaseTableViewCell.identifier, indexPath: indexPath) as MovieShowCaseTableViewCell
            
            
            cell.showcaseMovieList = returnTheTopRatedMovieList()
            cell.delegate = self
            
            return cell
            
        case Constants.bestActorTableViewCell.rawValue:
            let cell = movieTableView.bindTableViewCellsToYourTableView(cell: BestActorTableViewCell.identifier, indexPath: indexPath) as BestActorTableViewCell
            
            cell.actorReceived = actorReceivedFromTheServer
            cell.delegate = self
            
            return cell
        default :
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section
        {
        case Constants.movieSliderTableViewCell.rawValue:return CGFloat(250)
        case Constants.bestSeriesTableViewCell.rawValue: return CGFloat(425)
        case Constants.bestPopularSeriesTableViewCell.rawValue: return CGFloat(425)
        case Constants.movieShowTimeCell.rawValue: return CGFloat(234)
        case Constants.genreLableTableViewCell.rawValue: return CGFloat(422)
        case Constants.movieShowCaseTableViewCell.rawValue: return CGFloat(308)
        case Constants.bestActorTableViewCell.rawValue:return CGFloat(341)
        default :return CGFloat(0)
        }
        
    }
    
}

extension MovieViewController
{
    private func returnTheMovieList() -> Array<MixedMoviesAndSeriesList>
    {
        guard let mixedMovieList =  upcomingMovieFromServer?.results?.map({ Movie -> MixedMoviesAndSeriesList in
               return MixedMoviesAndSeriesList(adult: Movie.adult ?? false, video: Movie.video ?? false, backdropPath: Movie.backdropPath ?? "", firstAirDate: Movie.releaseDate ?? "", genreID: Movie.genreIDS ?? Array<Int>(), id: Movie.id ?? 0, name: Movie.title ?? "", originCountry: [""] , originalLanguage: Movie.originalLanguage ?? "", originalName: Movie.originalTitle ?? "", overview: Movie.overview ?? "", popularity: Movie.popularity ?? 0.0, posterPath: Movie.posterPath ?? "", voteAverage: Movie.voteAverage ?? 0.0, voteCount: Movie.voteCount ?? 0, typeOfTheFilm: .movies)
            
        })  else {return Array<MixedMoviesAndSeriesList>()}
        
        return mixedMovieList
    }
    
    private func returnTheSeriesList() -> Array<MixedMoviesAndSeriesList>
    {
     guard let mixedSeriesList = seriesDataFromServer?.results?.map({ Series -> MixedMoviesAndSeriesList in
         
         return MixedMoviesAndSeriesList(adult: false , video: false, backdropPath: Series.backdropPath ?? "", firstAirDate: Series.firstAirDate ?? "", genreID: Series.genreIDS ?? Array<Int>(), id: Series.id ?? 0, name: Series.name ?? "", originCountry: Series.originCountry ?? Array<String>(), originalLanguage: Series.originalLanguage ?? "", originalName: Series.originalName ?? "", overview: Series.overview ?? "", popularity: Series.popularity ?? 0.0, posterPath: Series.posterPath ?? "", voteAverage: Series.voteAverage ?? 0.0, voteCount: Series.voteCount ?? 0, typeOfTheFilm: .series)
         
     }) else {return Array<MixedMoviesAndSeriesList>()}
        
       return mixedSeriesList
    }
    
    private func returnThePopularMovieList() -> Array<MixedMoviesAndSeriesList>
    {
       guard let popularMovieList = popularMovieDataFromServer?.results?.map({ popularFim -> MixedMoviesAndSeriesList in
           return MixedMoviesAndSeriesList(adult: popularFim.adult ?? false, video: popularFim.video ?? false, backdropPath: popularFim.backdropPath ?? "", firstAirDate: popularFim.releaseDate ?? "", genreID: popularFim.genreIDS ?? Array<Int>(), id: popularFim.id ?? 0, name: popularFim.title ?? "", originCountry: nil, originalLanguage: popularFim.originalLanguage ?? "", originalName: popularFim.originalTitle ?? "", overview: popularFim.overview ?? "", popularity: popularFim.popularity ?? 0.0, posterPath: popularFim.posterPath ?? "", voteAverage: popularFim.voteAverage ?? 0.0, voteCount: popularFim.voteCount ?? 0, typeOfTheFilm: .movies)
       }) else {
           return Array<MixedMoviesAndSeriesList>()
       }
                return popularMovieList
    }
    
    private func returnTheTopRatedMovieList()->Array<MixedMoviesAndSeriesList>
    {
        guard let topRatedMovieList = topRatedMovie?.results?.map({ popularFim -> MixedMoviesAndSeriesList in
            return MixedMoviesAndSeriesList(adult: popularFim.adult ?? false, video: popularFim.video ?? false, backdropPath: popularFim.backdropPath ?? "", firstAirDate: popularFim.releaseDate ?? "", genreID: popularFim.genreIDS ?? Array<Int>(), id: popularFim.id ?? 0, name: popularFim.title ?? "", originCountry: nil, originalLanguage: popularFim.originalLanguage ?? "", originalName: popularFim.originalTitle ?? "", overview: popularFim.overview ?? "", popularity: popularFim.popularity ?? 0.0, posterPath: popularFim.posterPath ?? "", voteAverage: popularFim.voteAverage ?? 0.0, voteCount: popularFim.voteCount ?? 0, typeOfTheFilm: .movies)
        }) else {
            return Array<MixedMoviesAndSeriesList>()
        }
                 return topRatedMovieList
    }
}

extension MovieViewController:MovieItemDelegate
{
    func onTabMovieShowCase()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MovieShowCaseViewController") as? MovieShowCaseViewController else {return}
        
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .formSheet
//
//        present(vc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
                
    }
    
    func onTabActor(actorID: Int) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "ActorDetailViewController") as? ActorDetailViewController else {return}
        
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .formSheet
        
        vc.actorID = actorID
        
        self.navigationController?.pushViewController(vc,animated:true)
        
    }
    
    func onTabMoreActors() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "ActorListPaginationViewController") as? ActorListPaginationViewController else {return}
        
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .formSheet
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onTabGenreMovieAndSeries(typeOfFilm:TypeOfTheFilm,filmID:Int)
    {
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {return}
        
        debugPrint(typeOfFilm.rawValue)
        
        vc.filmID = filmID
        vc.typeOfFilm = typeOfFilm
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onTabMovieSliderContent()
    {
        navigateToMovieDetailViewController()
    }
    
}
