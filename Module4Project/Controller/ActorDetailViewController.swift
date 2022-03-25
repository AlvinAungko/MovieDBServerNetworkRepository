//
//  ActorDetailViewController.swift
//  Module4Project
//
//  Created by Alvin  on 19/03/2022.
//

import UIKit
import SDWebImage

class ActorDetailViewController: UIViewController {

    
    
    @IBOutlet weak var actorOverViewLabel: UILabel!
    
    fileprivate let actorModelLayer = ActorModelLayer.actorModelLayer
    
    var actorCombinedFilm:Array<MixedMoviesAndSeriesList>?
    {
        didSet
        {
            if let _ = actorCombinedFilm {
                self.actorMovieList.reloadData()
                actorCombinedFilm?.forEach({ movie in
                    debugPrint(movie.originalName ?? "")
                })
            } else {
                debugPrint("No data is presented")
            }
        }
    }
    
//    var actorCombinedMovie:Array<ActorCast>?
//    {
//        didSet{
//            if let _ = actorCombinedMovie
//            {
//                self.actorMovieList.reloadData()
//            }
//        }
//    }
    
    var actorID:Int?
    
    let networkAgent = NetworkingAgentAPI.shared
    
    var detailOfTheActor:ActorDetailDataModel?
    {
        didSet
        {
            if let data = detailOfTheActor
            {
                self.actorImage.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.profilePath ?? "")"))
                self.actorOverView.text = data.name ?? ""
                self.actorOverViewLabel.text = data.biography ?? ""
                self.navigationItem.title = "\(data.name ?? "")"
            }
        }
    }
    
    
    @IBOutlet weak var heightOfActorCollectionView: NSLayoutConstraint!
    @IBOutlet weak var actorOverView: UILabel!
    @IBOutlet weak var actorMovieList: UICollectionView!
    @IBOutlet weak var actorImage: UIImageView!
    
    deinit {
        debugPrint("Actor Detail has been removed from the memory.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDateSourceAndDelegate()
        registerCells()
        setUpHeight()
        
        guard let actorID = actorID else {
            debugPrint("No Actor ID")
            return
        }
        fetchTheDetailOfTheActor(actorID: actorID)
        fetchTheMoviesOfActor(actorID: actorID)
        
        // Do any additional setup after loading the view.
    }
    

    
}

extension ActorDetailViewController
{
    private func fetchTheDetailOfTheActor(actorID:Int)
    {
        actorModelLayer.fetchTheDetailOfTheActor(actorID: actorID) { [weak self] actorDetail in
            
            guard let self = self else {return}
            
            switch actorDetail
            {
            case.sucess(let actorDetail):self.detailOfTheActor = actorDetail
            case.failure(let errorMessage):debugPrint(errorMessage)
            }
            
        }

    }
    
    private func fetchTheMoviesOfActor(actorID:Int)
    {
        actorModelLayer.fetchTheListOfCombinedMoviesThatTheActorStaredIn(actorID: actorID) { [weak self] actorCombinedFilm in
            
            guard let self = self else {
                return
            }
            
//            self.actorCombinedMovie = actorCombinedFilm.cast ?? Array<ActorCast>()
            
            switch actorCombinedFilm
            {
            case.sucess(let actorCombinedFilm):
                
                self.actorCombinedFilm = actorCombinedFilm.cast?.map({
                    
                    MixedMoviesAndSeriesList(adult: $0.adult ?? false, video: $0.video ?? false, backdropPath: $0.backdropPath ?? "", firstAirDate: $0.firstAirDate ?? "", genreID: $0.genreIDS ?? Array<Int>(), id: $0.id, name: $0.name, originCountry: $0.originCountry ?? Array<String>(), originalLanguage: $0.originalLanguage ?? "", originalName: $0.originalTitle ?? "", overview: $0.overview ?? "", popularity: $0.popularity ?? 0.0, posterPath: $0.posterPath ?? "", voteAverage: $0.voteAverage ?? 0.0, voteCount: $0.voteCount ?? 0, typeOfTheFilm: .movies)
                    
                })
                
            case.failure(let errorMessage):debugPrint(errorMessage)
                
            }
            
        }

    }
}


extension ActorDetailViewController
{
    private func setUpDateSourceAndDelegate()
    {
        actorMovieList.dataSource = self
        actorMovieList.delegate = self
    }
    
    private func registerCells()
    {
        actorMovieList.registerCollectionViewCells(cell: BestFilmCollectionViewCell.identifier)
    }
    
    private func setUpHeight()
    {
        heightOfActorCollectionView.constant = 385
    }
}

extension ActorDetailViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorCombinedFilm?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = actorMovieList.bindCollectionCellsToYourCollectionView(cell: BestFilmCollectionViewCell.identifier, indexPath: indexPath) as BestFilmCollectionViewCell
        
        cell.mixedMovieAndSeries = actorCombinedFilm?[indexPath.row]
        
        cell.onTabFilm = { [weak self]
            filmID,TypeOfFilm in
            
            guard let self = self else {
                return
            }
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {return}
            
            
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            
            vc.filmID = filmID
            vc.typeOfFilm = TypeOfFilm
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: actorMovieList.frame.width/2.5, height: 385)
    }
    
    
}
