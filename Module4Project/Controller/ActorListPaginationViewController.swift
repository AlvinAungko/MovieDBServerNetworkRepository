//
//  ActorListPaginationViewController.swift
//  Module4Project
//
//  Created by Alvin  on 19/03/2022.
//

import UIKit

class ActorListPaginationViewController: UIViewController {

    
    @IBOutlet weak var actorListCollectionView: UICollectionView!
    
    fileprivate let actorModelLayer = ActorModelLayer.actorModelLayer
    
    let networkDBAgent = NetworkingAgentAPI.shared
    
    var currentPage:Int = 1
    var numberOfPages:Int = 1
    
//    var hasNumberOfPages = Bool()
    
    
    // MARK: This is where the data is permanently stored and this list will grow accoring to every network call that user submitted and this list will send data to the collectionView which will  present the information to the user
    
    var appendActorList = Array<Actor>()
    
    //MARK: Temporarily storing data from the networkCall since the data inside this variable will be overwritted when it is recalled again, but once it recieves the value, it immediately appends it to the appendActorList array.

    
    var actirData : Array<Actor>?
    {
        didSet
        {
            if let _ = actirData
            {
                self.appendActorList.append(contentsOf: actirData ?? Array<Actor>())
                self.actorListCollectionView.reloadData()
            }
        }
    }
    
    deinit {
        debugPrint(" Actor Pagination is removed from the memory.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callTheNetwork(pageNumber:currentPage)
        setDataSourceAndDelegate()
        registerCells()
        self.navigationItem.title = "More Actors"

        
        // Do any additional setup after loading the view.
    }
    

}

//MARK: Keeping the reference between the closure and the self class weak is essential so that it is affordable to deallocate that self class from the memory

extension ActorListPaginationViewController
{
    private func callTheNetwork(pageNumber:Int)
    {
        actorModelLayer.fetchTheActorList(page:pageNumber){ [weak self]  actorData in
            
            // MARK: The code below will work only if the viewcontroller is still on the memory
            
            guard let self = self else {
                return
            }
            
            switch actorData
            {
            case.sucess(let actorData):
                
                
                
                self.actirData = actorData.results ?? Array<Actor>()
                
                self.currentPage = actorData.page ?? 0
                self.numberOfPages = actorData.totalPages ?? 0
                
            case.failure(let errorMessage):debugPrint(errorMessage)
                
                
            }
            
            
        }
    }
}


extension ActorListPaginationViewController
{
    private func setDataSourceAndDelegate()
    {
        actorListCollectionView.delegate = self
        actorListCollectionView.dataSource = self
    }
    
    private func registerCells()
    {
        actorListCollectionView.registerCollectionViewCells(cell: BestActorCollectionViewCell.identifier)
    }
}

extension ActorListPaginationViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appendActorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = actorListCollectionView.bindCollectionCellsToYourCollectionView(cell: BestActorCollectionViewCell.identifier, indexPath: indexPath) as BestActorCollectionViewCell
        
        cell.actorObject = appendActorList[indexPath.row]
        
        cell.onTabActor = { [weak self]
            actorID in
            
            guard let self = self else {return}
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "ActorDetailViewController") as? ActorDetailViewController else {return}
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .formSheet
            
            vc.actorID = actorID
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: actorListCollectionView.bounds.width/3.5, height: 280)
    }
    
    // MARK: Will fetch new data if we are at the last row and pages are still left
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let isLastRow = indexPath.row == ((actirData?.count ?? 0) - 1)
       
        let hasMorePages = currentPage < numberOfPages
        
        if isLastRow && hasMorePages
        {
            currentPage += 1
            callTheNetwork(pageNumber: currentPage)
        }
       
    }
}
