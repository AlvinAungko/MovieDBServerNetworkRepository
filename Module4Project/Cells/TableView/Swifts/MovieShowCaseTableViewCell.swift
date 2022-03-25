//
//  MovieShowCaseTableViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit

class MovieShowCaseTableViewCell: UITableViewCell {
    
    var delegate:MovieItemDelegate?
    
    var showcaseMovieList: Array<MixedMoviesAndSeriesList>?
    {
        didSet{
            if let _ = showcaseMovieList
            {
                self.movieShowCaseCollectionView.reloadData()
            }
        }
    }

    @IBOutlet weak var heightOfShowCaseMovieCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var movieShowCaseCollectionView: UICollectionView!
    @IBOutlet weak var moreShowCasesLabel: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        addGesture()
        registerCells()
        setUpHeightForShowCaseColelction()
        setDataSourceAndDelegate()
        underLineLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MovieShowCaseTableViewCell
{
    private func addGesture()
    {
        let tapGestureReognizer = UITapGestureRecognizer(target: self, action: #selector(onTabMoreShowCase))
        moreShowCasesLabel.addGestureRecognizer(tapGestureReognizer)
        moreShowCasesLabel.isUserInteractionEnabled = true
    }
    
    @objc func onTabMoreShowCase()
    {
        delegate?.onTabMovieShowCase()
    }
    
    
    private func bindDataToTheList()
    {
        
    }
    
    private func setUpHeightForShowCaseColelction()
    {
        
        let itemWidth = movieShowCaseCollectionView.bounds.width - 50
        let itemHeight = (itemWidth/16)*9
        heightOfShowCaseMovieCollectionView.constant = itemHeight
    }
}

extension MovieShowCaseTableViewCell
{
    private func setDataSourceAndDelegate()
    {
        movieShowCaseCollectionView.dataSource = self
        movieShowCaseCollectionView.delegate = self
    }
    
    private func registerCells()
    {
        movieShowCaseCollectionView.registerCollectionViewCells(cell: MovieShowCaseCollectionViewCell.identifier)
    }
    
    private func underLineLabel()
    {
        moreShowCasesLabel.attributedText = moreShowCasesLabel.returnAttributedString(text: "More Showcases")
    }
}

extension MovieShowCaseTableViewCell:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showcaseMovieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = movieShowCaseCollectionView.bindCollectionCellsToYourCollectionView(cell: MovieShowCaseCollectionViewCell.identifier, indexPath: indexPath) as MovieShowCaseCollectionViewCell
        
        cell.topRatedFilm =  showcaseMovieList?[indexPath.row]
        
        cell.onTabFilm = {
            id,typeOftheFilm in
            
            self.delegate?.onTabGenreMovieAndSeries(typeOfFilm: typeOftheFilm, filmID: id)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = movieShowCaseCollectionView.bounds.width - 50
        let itemHeight = (itemWidth/16)*9
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ((scrollView.subviews[(scrollView.subviews.count-1)]).subviews[0]).backgroundColor = UIColor(named: "Text Color")
        
    }
}
