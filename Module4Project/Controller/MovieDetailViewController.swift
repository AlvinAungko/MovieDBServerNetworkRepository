//
//  MovieDetailViewController.swift
//  Module4Project
//
//  Created by Alvin  on 08/02/2022.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var heightOfCastCollectionView: NSLayoutConstraint!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var heightOfCreatorCollectionView: NSLayoutConstraint!
    var dummyActorList = Array<DummyActor>()
    
    let movieDBAgent = NetworkingAgentAPI.shared
    
    var filmID:Int?
    var typeOfFilm:TypeOfTheFilm?
    
    fileprivate let movieModelLayer = MovieModelLayer.movieModel
    
    fileprivate let seriesModelLayer = SeriesModelLayer.seriesModelLayer
    
    
    // MARK: Actor Data
    
    var castList:Array<Actor>?
    {
        didSet
        {
            if let _ = castList
            {
                self.castCollectionView.reloadData()
            }
        }
    }
    
    // MARK: Cast Data
    
    var actorList:Array<Cast>?
    {
        didSet{
            if let _ = actorList
            {
                self.castList = actorList?.map({ cast -> Actor in
                    return Actor(adult: cast.adult ?? false, gender: cast.gender ?? 0, id: cast.id ?? 0, knownFor: Array<KnownFor>(), knownForDepartment: cast.knownForDepartment ?? "", name: cast.name ?? "", popularity: cast.popularity ?? 0.0, profilePath: cast.profilePath ?? "")
                })
            }
        }
    }
    
    
    // MARK: Creator
    
    var creators:Array<CreatedBy>?
    {
        didSet
        {
            if let _ = creators
            {
                self.actorCollectionView.reloadData()
            } else {
                creatorView.isHidden = true
            }
        }
    }
    
    // MARK: Production Company
    
    var productionCompanies:Array<ProductionCompany>?
    {
        didSet
        {
            if let _ = productionCompanies
            {
                self.creatorCollectionView.reloadData()
            }
        }
       
    }
    
    //MARK: Genres
    
    var genre:Array<Genre>?
    {
      didSet
        {
            if let _ = genre
            {
                self.genreSmallTableView.reloadData()
            }
        }
    }
    
    //MARK: Trailer
    
    var trailer:TVTrailer?
    
    
    var movieDetail:MovieDetail?
    {
        didSet{
            if let detailOfTheMovie = movieDetail
            {
                filmBackdropPathImage.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(detailOfTheMovie.backdropPath ?? "")"))
                
                filmOrignialTitle.text = detailOfTheMovie.originalTitle ?? ""
                filmTitleLabel.text = detailOfTheMovie.title ?? ""
                filmOverViewLabel.text = detailOfTheMovie.overview ?? ""
                overviewOfTheFilmLabel.text = detailOfTheMovie.overview ?? ""
                releaseDateOfTheFilmLabel.text = detailOfTheMovie.releaseDate ?? ""
                productionCompanies = detailOfTheMovie.productionCompanies ?? Array<ProductionCompany>()
                creators = nil
                
                genre = detailOfTheMovie.genres ?? Array<Genre>()
                
                filmCategoryLabel.text = detailOfTheMovie.genres?.map({ gere -> String in
                    gere.name ?? ""
                }).reduce(String(), { partialResult, genreTitle in
                    return "\(partialResult) \(genreTitle)"
                })
                
                productionCountryLabel.text = detailOfTheMovie.productionCountries?.map({ country -> String in
                    country.name ?? ""
                }).reduce(String(), { partialResult, secondValue -> String in
                    return "\(partialResult) \(secondValue)"
                })
                
                self.navigationItem.title = "\(detailOfTheMovie.title ?? "")"
            }
        }
    }
    
    var seriesDetail:SeriesDetail?
    {
        didSet
        {
            if let detailOfTheSeries = seriesDetail
            {
                filmBackdropPathImage.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(detailOfTheSeries.backdropPath ?? "")"))
                
                filmOrignialTitle.text = detailOfTheSeries.originalName ?? ""
                filmTitleLabel.text = detailOfTheSeries.name ?? ""
                filmOverViewLabel.text = detailOfTheSeries.overview ?? ""
                overviewOfTheFilmLabel.text = detailOfTheSeries.overview ?? ""
                releaseDateOfTheFilmLabel.text = detailOfTheSeries.firstAirDate ?? ""
                
                productionCompanies = detailOfTheSeries.productionCompanies ?? Array<ProductionCompany>()
                
                creators = detailOfTheSeries.createdBy ?? Array<CreatedBy>()
                
                genre = detailOfTheSeries.genres ?? Array<Genre>()
                
                filmCategoryLabel.text = detailOfTheSeries.genres?.map({ gere -> String in
                    gere.name ?? ""
                }).reduce(String(), { partialResult, genreTitle in
                    return "\(partialResult) \(genreTitle)"
                })
                
                productionCountryLabel.text = detailOfTheSeries.productionCountries?.map({ country -> String in
                    country.name ?? ""
                }).reduce(String(), { partialResult, secondValue -> String in
                    return "\(partialResult) \(secondValue)"
                })
              
                self.navigationItem.title = "\(detailOfTheSeries.name ?? "")"
            }
                
            }
        }
    
    

    @IBOutlet weak var creatorView: UIView!
    @IBOutlet weak var creatorCollectionView: UICollectionView!
    @IBOutlet weak var overviewOfTheFilmLabel: UILabel!
    @IBOutlet weak var releaseDateOfTheFilmLabel: UILabel!
    @IBOutlet weak var productionCountryLabel: UILabel!
    @IBOutlet weak var filmCategoryLabel: UILabel!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    @IBOutlet weak var filmOverViewLabel: UILabel!
    @IBOutlet weak var filmOrignialTitle: UILabel!
    @IBOutlet weak var filmBackdropPathImage: UIImageView!
    @IBOutlet weak var directorCollectionView: UICollectionView!
    @IBOutlet weak var backImageButton: UIImageView!
    @IBOutlet weak var rateMovieButton: UIButton!
    @IBOutlet weak var playTraillerButton: UIButton!
    @IBOutlet weak var genreSmallTableView: UITableView!
    @IBOutlet weak var labelToRound: UILabel!
    @IBOutlet weak var actorReuseCollectionView: UICollectionView!
    
    deinit {
        debugPrint("Movie Detail has been removed from the memory")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        setupHeight()
        bindDataToTheList()
        addGesture()
        roundLabel()
        addBorder()
        registerCells()
        setDataSourceAndDelegate()
        
        doNetworkCallAccordingToTheTypeOfFilm (id: filmID ?? 0, typeOfFilm: typeOfFilm ?? .movies)
       
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTabPlayTrailer(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "TrailerViewController") as? TrailerViewController else {
            debugPrint("No vc")
            return
            
        }
        
        vc.modalPresentationStyle = .formSheet
        
        vc.modalTransitionStyle = .coverVertical
        
        guard let trailerList = trailer else {
            
            debugPrint("No Trailer")
            
            return
            
        }
        
//        for eachItem in trailerList
//        {
//            debugPrint(eachItem.name ?? "")
//        }
        
        vc.trailerList = trailerList
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    

}

extension MovieDetailViewController
{
    //MARK: Calling network call according to filmType
    
    private func doNetworkCallAccordingToTheTypeOfFilm(id:Int,typeOfFilm:TypeOfTheFilm)
    {
        switch typeOfFilm
        {
        case.movies:
            
            movieModelLayer.fetchTheMovieDetail(movieID: id) { [weak self] movieDetail in
                
                guard let self = self else {return}
                
                switch movieDetail
                {
                case.sucess(let movieDetail): self.movieDetail = movieDetail
                case.failure(let errorMessage):debugPrint(errorMessage)
                }
                
        }
            
            movieModelLayer.fetchTheCreditsAccordingToTheMovieID(movieID: id) { [weak self]  creitsForMovie in
                
                guard let self = self else {return}
                
                switch creitsForMovie
                {
                case.sucess(let creitsForMovie):self.actorList = creitsForMovie.cast ?? Array<Cast>()
                case.failure(let errorMessage):debugPrint(errorMessage)
                }
                
                
                
            }
            
            movieModelLayer.fetchTheMovieTrailers(moviesID: id) { [weak self] tvTrailer in
                
                guard let self = self else {return}
                
                switch tvTrailer
                {
                case.sucess(let tvTrailer): self.trailer = tvTrailer
                case.failure(let errorMessage):debugPrint(errorMessage)
                }
                
            
            }


        case.series:
            
            seriesModelLayer.fetchTheSerieDetail(seriesID: id) { [weak self] seriesDetail in
                
                guard let self = self else {return}
                
                switch seriesDetail
                {
                case.sucess(let seriesDetail):self.seriesDetail = seriesDetail
                case.failure(let errorMessage):debugPrint(errorMessage)
                }
                
                
                
        }
            
            seriesModelLayer.fetchTheCastAccordingToTheSeriesID(seriesID: id) { [weak self] creditsForSeries in
                
                guard let self = self else {return}
                
                switch creditsForSeries
                {
                case.sucess(let creditsForSeries): self.actorList = creditsForSeries.cast ?? Array<Cast>()
                case.failure(let errorMessage):debugPrint(errorMessage)
                }
                
               
                
            }
            
            seriesModelLayer.fetchTheTvTrailers(seriesID: id) { [weak self] tvTrailer in
                
                guard let self = self else {return}
                
                switch tvTrailer
                {
                case.sucess(let tvTrailer):self.trailer = tvTrailer
                case.failure(let errorMessage):debugPrint(errorMessage)
                }
                
                
            }


        }
    }
}

extension MovieDetailViewController
{
    private func setupHeight()
    {
        heightOfCreatorCollectionView.constant = 220
        heightOfCastCollectionView.constant = 280
    }
    
    
    private func setDataSourceAndDelegate()
    {
        
        genreSmallTableView.dataSource = self
        genreSmallTableView.delegate = self
        
        actorReuseCollectionView.dataSource = self // naming needed
        actorReuseCollectionView.delegate = self
        
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        
        creatorCollectionView.dataSource = self
        creatorCollectionView.delegate = self
      
    }
    
    private func registerCells()
    {
        genreSmallTableView.registerTableViewCells(cell: GenreSmallTableViewCell.identifier)
        
        actorReuseCollectionView.registerCollectionViewCells(cell: BestActorCollectionViewCell.identifier)
        
        castCollectionView.register(UINib(nibName: String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
        
        creatorCollectionView.registerCollectionViewCells(cell: CreatorAndCompanyCollectionViewCell.identifier)
    }
}

extension MovieDetailViewController
{
    private func addGesture()
    {
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(tapOnBack))
        backImageButton.addGestureRecognizer(gestureRecog)
        backImageButton.isUserInteractionEnabled = true
    }
    
    private func roundLabel()
    {
        labelToRound.clipsToBounds = true
        labelToRound.layer.cornerRadius = 9
    }
    
    @objc func tapOnBack()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func bindDataToTheList()
    {
        dummyActorList = [DummyActor(name: "Kabuzam Kimoji Noo", like: 100, image: "firstActorImage"),DummyActor(name: "Sarutobi Yabuza Kaigo", like: 0, image: "secondImage"),DummyActor(name: "I am RunningMan", like: 123, image: "thirdImage")]
    }
    
    private func addBorder()
    {
        rateMovieButton.layer.borderWidth = 1
        rateMovieButton.layer.cornerRadius = 12
        rateMovieButton.layer.borderColor = UIColor.yellow.cgColor
    }
}

extension MovieDetailViewController:UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = genreSmallTableView.bindTableViewCellsToYourTableView(cell: GenreSmallTableViewCell.identifier, indexPath: indexPath) as GenreSmallTableViewCell
        
        cell.genreList = genre
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section
        {
    case 0: return CGFloat(60)
    default : return CGFloat(0)
        }
    }
    
}

extension MovieDetailViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView
        {
        case actorCollectionView: return creators?.count ?? 0
        case creatorCollectionView: return productionCompanies?.count ?? 0
        case castCollectionView: return castList?.count ?? 0
        default: return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView
        {
        case actorCollectionView:
            
            guard let cell = actorCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.creator = creators?[indexPath.row]
            
            return cell
            
        case creatorCollectionView:
            let cell = creatorCollectionView.bindCollectionCellsToYourCollectionView(cell: CreatorAndCompanyCollectionViewCell.identifier, indexPath: indexPath) as CreatorAndCompanyCollectionViewCell
            cell.productionCompany = productionCompanies?[indexPath.row]
            return cell
            
        case castCollectionView:
            let cell = castCollectionView.bindCollectionCellsToYourCollectionView(cell: BestActorCollectionViewCell.identifier, indexPath: indexPath) as BestActorCollectionViewCell
            
            cell.actorObject = castList?[indexPath.row]
            
            cell.onTabActor = { [weak self]
                actorID in
                
                guard let self = self else {return}
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                
                guard let vc = storyBoard.instantiateViewController(withIdentifier: "ActorDetailViewController") as? ActorDetailViewController else {return}
                
                vc.actorID = actorID
                
//                vc.modalTransitionStyle = .coverVertical
//                vc.modalPresentationStyle = .formSheet
                
                
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
            
        default: return UICollectionViewCell()
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       switch collectionView
        {
       case actorCollectionView: return CGSize(width: actorCollectionView.bounds.width/2.2, height: 280)
           
       case castCollectionView: return CGSize(width: castCollectionView.bounds.width/2.2, height: 280)
           
       case creatorCollectionView: return CGSize(width: creatorCollectionView.bounds.width/2.3, height: heightOfCreatorCollectionView.constant)
           
       default:return CGSize(width: 0, height: 0)
       }
        
       
    }
//    func widthOfString(content:String,font:UIFont) -> CGFloat
//    {
//        var textAttribute:Dictionary<NSAttributedString.Key,UIFont> = Dictionary()
//        textAttribute = [NSAttributedString.Key.font:font]
//        let sizeOfContent = content.size(withAttributes: textAttribute)
//        return sizeOfContent.width
//
//    }
    
}
