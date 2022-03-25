//
//  BestActorTableViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import UIKit

class BestActorTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var actorMoreLabel: UILabel!
    var actorReceived:ActorDataModel?
    {
        didSet{
            if let _ = actorReceived{
                self.actorCollectionView.reloadData()
            }
        }
    }
    
    var delegate:MovieItemDelegate?
    
    var actorImageList:Array<DummyActor> = Array()

    @IBOutlet weak var actorCollectionView: UICollectionView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        addGesture()
        bindTheDataToTheDummyList()
        registerCells()
        setDataSourceAndDelegate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BestActorTableViewCell
{
    private func bindTheDataToTheDummyList()
    {
        actorImageList = [DummyActor(name: "Uzumaki Naruto", like: 12, image: "firstActorImage"),DummyActor(name: "American BadAss", like: 123, image: "secondImage"), DummyActor(name: "Tanjuro Killer Yamaha", like: 20, image: "thirdImage"), DummyActor(name: "Eren Yaegar BabyBoo", like: 0, image: "forthImage"), DummyActor(name: "HAHAHAHAHA", like: 1234, image: "fifthImage") ]
    }
}

extension BestActorTableViewCell
{
    private func registerCells()
    {
        actorCollectionView.registerCollectionViewCells(cell: BestActorCollectionViewCell.identifier)
    }
    
    private func setDataSourceAndDelegate()
    {
        actorCollectionView.dataSource = self
        actorCollectionView.delegate = self
    }
    
    private func addGesture()
    {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTabMoreActors))
        actorMoreLabel.isUserInteractionEnabled = true
        actorMoreLabel.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func onTabMoreActors()
    {
        delegate?.onTabMoreActors()
    }
}

extension BestActorTableViewCell:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorReceived?.results?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = actorCollectionView.bindCollectionCellsToYourCollectionView(cell: BestActorCollectionViewCell.identifier, indexPath: indexPath) as BestActorCollectionViewCell
        
        cell.actorObject = actorReceived?.results?[indexPath.row]
        
        cell.onTabActor = {
            actorID in
            
            self.delegate?.onTabActor(actorID: actorID)
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let widthOfFirstContent = widthOfString(content: actorReceived?.results?[indexPath.row].name ?? "", font: UIFont(name: "Roboto-BoldItalic", size: 18) ?? UIFont.systemFont(ofSize: 17))
        
        
        return CGSize(width: widthOfFirstContent+50, height: 280)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.onTabFullTabBar(isOnTabbedFullBookMark: actorImageList[indexPath.row].actorName)
//    }
    
    func widthOfString(content:String,font:UIFont) -> CGFloat
    {
        var textAttribute:Dictionary<NSAttributedString.Key,UIFont> = Dictionary()
        textAttribute = [NSAttributedString.Key.font:font]
        let sizeOfContent = content.size(withAttributes: textAttribute)
        return sizeOfContent.width
        
    }
}
