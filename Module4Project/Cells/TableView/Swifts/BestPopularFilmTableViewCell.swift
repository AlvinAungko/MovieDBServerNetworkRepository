//
//  BestPopularFilmTableViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit

class BestPopularFilmTableViewCell: UITableViewCell {
    
    var delegate:MovieItemDelegate?
    
    var dataForBothMoviesAndSeries:Array<MixedMoviesAndSeriesList>?
    {
        didSet
        {
            if let _ = dataForBothMoviesAndSeries
            {
                self.bestFilmsCollectionView.reloadData()
            }
        }
    }
    
    
    var movieList:Array<DummySeriesModel> = Array()

    @IBOutlet weak var bestFilmsCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bindDataToMyMovieList()
        registerCells()
        setUpDataSourceAndDelegate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BestPopularFilmTableViewCell
{
    private func bindDataToMyMovieList()
    {
        movieList = [DummySeriesModel(name: "firstSeriesImage"),DummySeriesModel(name: "secondSeriesImage"),DummySeriesModel(name: "thirdSeriesImage"),DummySeriesModel(name: "forthSeriesImage"),DummySeriesModel(name: "fifthSeriesImage")]
    }
}

extension BestPopularFilmTableViewCell
{
    private func setUpDataSourceAndDelegate()
    {
        bestFilmsCollectionView.dataSource = self
        bestFilmsCollectionView.delegate = self
    }
    
    private func registerCells()
    {
        bestFilmsCollectionView.registerCollectionViewCells(cell: BestFilmCollectionViewCell.identifier)
    }
}

extension BestPopularFilmTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataForBothMoviesAndSeries?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = bestFilmsCollectionView.bindCollectionCellsToYourCollectionView(cell: BestFilmCollectionViewCell.identifier, indexPath: indexPath) as BestFilmCollectionViewCell
            
            cell.mixedMovieAndSeries = dataForBothMoviesAndSeries?[indexPath.row]
            
            cell.onTabFilm = {
                id,TypeOfTheFilm in
                
                self.delegate?.onTabGenreMovieAndSeries(typeOfFilm: TypeOfTheFilm, filmID: id)
            }
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bestFilmsCollectionView.frame.width/2.5, height: 385)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.onTabMovieSliderContent()
    }
    
}
