//
//  BestActorCollectionViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit
import SDWebImage

class BestActorCollectionViewCell: UICollectionViewCell
{
    
    
    var onTabActor:(Int)->Void = {_ in}
    
    @IBOutlet weak var fullBookMarkImageView: UIImageView!
    @IBOutlet weak var emptyBookMarkImageView: UIImageView!
    
//    var delegate:ActorDelegate?
    
    
//    var productionCompany:ProductionCompany?
//    {
//        didSet
//        {
//            if let data = productionCompany
//            {
//                actorImageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.logoPath ?? "")"))
//                actorName.text = data.name ?? ""
//                actorPopularity.isHidden = true
//            }
//        }
//    }
    
    var cast:Cast?
    {
        didSet
        {
            if let data = cast
            {
                actorImageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.profilePath ?? "")"))
                actorName.text = data.name ?? ""
                actorPopularity.isHidden = true
            }
        }
        
    }
    
    
    var creator:CreatedBy?
    {
        didSet
        {
            if let data = creator
            {
                actorImageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.profilePath ?? "")"))
                actorName.text = data.name ?? ""
                actorPopularity.isHidden = true
            }
        }
    }
    
    var actorObject:Actor?
    {
        didSet{
            if let data = actorObject
            {
                self.actorPopularity.text = "Popularity >> \(data.popularity ?? 0.0)"
                self.actorName.text = data.name ?? ""
                self.actorImageView.sd_setImage(with: URL(string: "\(AppConstants.urlImage)\(data.profilePath ?? "")"))
            }
        }
    }
    
    var actor:DummyActor?
    {
        didSet
        {
            if let data = actor
            {
                self.actorPopularity.text = "Popularity >> \(data.popularity) "
                self.actorName.text = data.actorName
                self.actorImageView.image = UIImage(named: data.actorImage)
                
            }
        }
    }
    

    @IBOutlet weak var actorPopularity: UILabel!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        roundCorners()
        // Initialization code
        addGestureToEmptyTabBar()
        addGestureToFullTabBar()
        addGesture()

    }

}

extension BestActorCollectionViewCell
{
    private func roundCorners()
    {
        actorImageView.clipsToBounds = true
        actorImageView.layer.cornerRadius = 11
    }
    
    private func addGestureToEmptyTabBar()
    {
        let gestureRecognizerForEmptyTabBar = UITapGestureRecognizer(target: self, action: #selector(onTabEmptyTabBar))
        emptyBookMarkImageView.addGestureRecognizer(gestureRecognizerForEmptyTabBar)
        emptyBookMarkImageView.isUserInteractionEnabled = true
    }
    
    private func addGestureToFullTabBar()
    {
        let gestureRecognizerForFullTabBar = UITapGestureRecognizer(target: self, action: #selector(onTabFullTabBar))
        fullBookMarkImageView.addGestureRecognizer(gestureRecognizerForFullTabBar)
        fullBookMarkImageView.isUserInteractionEnabled = true
    }
    
    @objc func onTabEmptyTabBar()
    {
        emptyBookMarkImageView.isHidden = true
        fullBookMarkImageView.isHidden = false
        
    }
    
    @objc func onTabFullTabBar()
    {
        emptyBookMarkImageView.isHidden = false
        fullBookMarkImageView.isHidden = true
        
    }
}

extension BestActorCollectionViewCell
{
    private func addGesture()
    {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ontabImage))
        actorImageView.isUserInteractionEnabled = true
        actorImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func ontabImage()
    {
        onTabActor(actorObject?.id ?? 0)
    }
}

