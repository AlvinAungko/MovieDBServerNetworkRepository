//
//  GenreLabelTableViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit

class GenreLabelTableViewCell: UITableViewCell {
    
    // Genre
    
    var onTabMovieAndSeriesDelegate:MovieItemDelegate?
    
    var genreList:[GenreList]?
    {
        didSet
        {
            if let _ = genreList
            {
                movieToShowCollectionView.reloadData()
                
                /*
                    We use this method to ensure that each category presents a list of movies and series to the users under any circumstances
                 
                    we remove some genre objects from the genreList because the idS representing each of those objects doesn't seem to exist in the movieDB Server and therefore there are no movies and series listed for that categoryID in the movieAndSeriesByCategoryID dictionary.
                 
                    To accomplish this behavior, we capture the genre value which the user tabbed in with closure and then we search for the key that shares the same name as that value we got from closure. If the key extracted is found in the dictionary, we don't remove the object associated with that key from its list , but however, we remove the object when its key can't be found in the dictionary, and if we keep that object in our list, whenever a user tabbed the genre, we will not be able to extract the listOfFilms according to that key since that key doesn't exist in the mdb server.
                 
                 */
                
                genreList?.removeAll(where: { genre -> Bool in
                    
                    let genreID = genre.id 
                    
                  let results =   movieAndSeriesByCategoryID.filter { (key,value) in
                      
                        genreID == key
                    }
                    
                    return results.count == 0
                    
                })
                
            }
        }
    }
    
    // Show a specific movie whenever it is tabbed
    
    var selectedMovieList:[MovieList]?
    {
        didSet
        {
            if let _ = selectedMovieList
            {
                self.movieToShowCollectionView.reloadData()
            }
        }
    }
    
    /*
     Making a storage to store movies by its category
  
     1. We fetch the movie list from the server and extract the category id from each movie.
     2. Each movie is expected to hold a category id and the same category id can be found in other movie as well.
     3. So, we create a dictinoary to store the lists of movies according to their category ID.
     4. So, whenever a user tabbed a genre, we capture the genreID and extract the movie list according to that genreID.
     5. Then the movielist retrieved from the genreID is transfered to another property to store them explicitly
     
     */

    // Setup A category movie list with a dictionary
    
//    var movieListByCategory = Dictionary<Int,Set<MovieList>>() // extracting a specific movie list accoring to the categoryID
    
    
    // Storing the moviesAndSeries extracted from the respective categoryID
    
    var selectedMovieAndSeriesList:Array<MixedMoviesAndSeriesList>?
    {
        didSet
        {
            if let _ = selectedMovieAndSeriesList
            {
                self.movieToShowCollectionView.reloadData()
            }
        }
    }
    
    
    // Storing Movies and Series by categoryID
    
    var movieAndSeriesByCategoryID = Dictionary<Int,Set<MixedMoviesAndSeriesList>>()
    
    // Capturing a mixedMovieAndSeriesList and setting up a storage for movieAndSeriesListBy Category
    
    var mixedMovieAndSeriesList: Array<MixedMoviesAndSeriesList>?
    {
        didSet{
            if let data = mixedMovieAndSeriesList
            {
                data.forEach { MixedSeriesAndMovies in
                    MixedSeriesAndMovies.genreID?.forEach({ categoryID in
                        
                        
                        
                        if var _ = movieAndSeriesByCategoryID[categoryID]
                        {
                            movieAndSeriesByCategoryID[categoryID]?.insert(MixedSeriesAndMovies)

                        }
                            else {
                            
                                movieAndSeriesByCategoryID[categoryID] = [MixedSeriesAndMovies]
                            }
                    })
                }
                
                extractTheMovieListFromTheCategory(genreID: 12)
            }
        }
    }
    
    
    
    // Capturing a combinedMovieList
    
//    var combinedMovieList:[MovieList]?
//    {
//        didSet
//        {
//            if let list = combinedMovieList
//            {
//                list.forEach { combinedMovie in
//                    combinedMovie.genreIDS?.forEach({ genreID in
//                        let categoryID = genreID
//
//                        if var _ = movieListByCategory[categoryID]
//                        {
//                            movieListByCategory[categoryID]?.insert(combinedMovie)
//                        } else
//                        {
//                            movieListByCategory[categoryID] = [combinedMovie]
//                        }
//                    })
//                }
//
//                extractTheMovieListFromTheCategory(genreID: 12)
//            }
//        }
//    }
    
    
    
    @IBOutlet weak var movieToShowCollectionView: UICollectionView!
    @IBOutlet weak var genreMovieCollectionView: UICollectionView!
    
    var dummyGenreLabelList:Array<DummyGenreLabel> = Array()
    var dummyMovielist = Array<DummySeriesModel>()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        addDataToTheList()
        registerCells()
        setDataSourceAndDelegate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension GenreLabelTableViewCell
{
    private func addDataToTheList()
    {
        dummyGenreLabelList = [DummyGenreLabel(text: "Thriller", hideorNot: false),DummyGenreLabel(text: "Adventure", hideorNot: true),DummyGenreLabel(text: "Criminal", hideorNot: true),DummyGenreLabel(text: "Drama", hideorNot: true),DummyGenreLabel(text: "Comedy", hideorNot: true)]
        
        dummyMovielist = [DummySeriesModel(name: "firstCategoryImage"),DummySeriesModel(name: "secondCategoryImage"),DummySeriesModel(name: "thirdCategoryImage"),DummySeriesModel(name: "forthCategoryImage")]
    }
    
    
}

extension GenreLabelTableViewCell
{
    private func registerCells()
    {
        genreMovieCollectionView.registerCollectionViewCells(cell: GenreLabelCollectionViewCell.identifier)
        movieToShowCollectionView.registerCollectionViewCells(cell: BestFilmCollectionViewCell.identifier)
    }
    
    private func setDataSourceAndDelegate()
    {
        genreMovieCollectionView.dataSource = self
        genreMovieCollectionView.delegate = self
        
        movieToShowCollectionView.delegate = self
        movieToShowCollectionView.dataSource = self
    }
    
}

extension GenreLabelTableViewCell:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == genreMovieCollectionView{
            return genreList?.count ?? 0
        } else
        {
            return selectedMovieAndSeriesList?.count ?? 0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == genreMovieCollectionView
        {
            
            let cell = genreMovieCollectionView.bindCollectionCellsToYourCollectionView(cell: GenreLabelCollectionViewCell.identifier, indexPath: indexPath) as GenreLabelCollectionViewCell
            
//            cell.dataToBind = dummyGenreLabelList[indexPath.row]
//            cell.onTabGenre = {
//                capturedGenre in
//                for eachGenre in self.dummyGenreLabelList
//            {
//                    if eachGenre.labelText == capturedGenre
//                {
//                    eachGenre.viewToHide = false
//                } else
//                {
//                    eachGenre.viewToHide = true
//                }
//            }
//                self.genreMovieCollectionView.reloadData()
//            }
            
            cell.GenreTypeData = genreList?[indexPath.row]
            
            cell.onTapGenreType = {
                captureGenre, genreID in
                
                self.genreList?.forEach({ genre in
                    if genre.name == captureGenre
                    {
                        genre.isSelected = true
                    } else {
                        genre.isSelected = false
                    }
                    
                })
                
                self.genreMovieCollectionView.reloadData()
                
                self.extractTheMovieListFromTheCategory(genreID: genreID)
                
            }
            
            return cell
        } else
        {
            let cell = movieToShowCollectionView.bindCollectionCellsToYourCollectionView(cell: BestFilmCollectionViewCell.identifier, indexPath: indexPath) as BestFilmCollectionViewCell
            
//            cell.combinedMovie = selectedMovieList?[indexPath.row]
            
            cell.mixedMovieAndSeries = selectedMovieAndSeriesList?[indexPath.row]
            
            cell.onTabFilm = {
                filmID,typeOfFilm in
                
                self.onTabMovieAndSeriesDelegate?.onTabGenreMovieAndSeries(typeOfFilm: typeOfFilm, filmID: filmID)
                
            }
            
            return cell
        }
        
    }
    
    private func extractTheMovieListFromTheCategory(genreID:Int)
    {
//        self.selectedMovieList = movieListByCategory[genreID]?.map{
//            $0
//        }
        
        self.selectedMovieAndSeriesList = movieAndSeriesByCategoryID[genreID]?.map({ $0
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if collectionView == genreMovieCollectionView{
            return CGSize(width: widthOfString(content: genreList?[indexPath.row].name ?? "", font: UIFont(name: "Roboto-BoldItalic", size: 18) ?? UIFont.systemFont(ofSize: 18)), height: 50)
        } else
        {
            return CGSize(width: movieToShowCollectionView.frame.width/2.5, height: 360)
        }
        
    }
    
    func widthOfString(content:String,font:UIFont) -> CGFloat
    {
        var textAttribute:Dictionary<NSAttributedString.Key,UIFont> = Dictionary()
        textAttribute = [NSAttributedString.Key.font:font]
        
        let textWidth = content.size(withAttributes: textAttribute)
        
        return textWidth.width
    }
        
}
