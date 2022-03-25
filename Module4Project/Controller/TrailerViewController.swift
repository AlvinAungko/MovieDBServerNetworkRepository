//
//  TrailerViewController.swift
//  Module4Project
//
//  Created by Aung Ko Ko on 18/03/2022.
//

import UIKit

class TrailerViewController: UIViewController {

    
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    
    var trailers:Array<Trailer>?
    {
        didSet
        {
            if let data = trailers
            {
                data.forEach { trailer in
                    debugPrint(trailer.name ?? "")
                }
            }
        }
    }
    
    // MARK: Capture the value sent from the DetailViewController
    
    var trailerList:TVTrailer?
    
    deinit {
        debugPrint("Trailer is removed from the memory.")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setDataSourceAndDelegate()
        registerCells()
        
        // MARK: This is to prevent the app from crashing due to capturing nil
        
        reloadTheCollectionView(data: trailerList?.results ?? Array<Trailer>())
        
//        guard let self = self else {return}
        self.navigationItem.title = "Trailer"
    }
    
}

extension TrailerViewController
{
    
    private func reloadTheCollectionView (data:Array<Trailer>)
    {
        
        self.trailers = data
        self.trailerCollectionView.reloadData()
    }
    
    private func registerCells()
    {
        trailerCollectionView.registerCollectionViewCells(cell: TrailerVideoCollectionViewCell.identifier)
    }
    
    private func setDataSourceAndDelegate()
    {
        trailerCollectionView.dataSource = self
        trailerCollectionView.delegate = self
    }
    
    
}

extension TrailerViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let trailers = trailers else {
            debugPrint("No trailers")
            return UICollectionViewCell()
            
        }
        
        
        let cell = trailerCollectionView.bindCollectionCellsToYourCollectionView(cell: TrailerVideoCollectionViewCell.identifier, indexPath: indexPath) as TrailerVideoCollectionViewCell
        
        cell.filmTrailer = trailers[indexPath.row]
        debugPrint(trailers[indexPath.row].key ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: trailerCollectionView.bounds.width/1.2, height: 177)
    }
}
