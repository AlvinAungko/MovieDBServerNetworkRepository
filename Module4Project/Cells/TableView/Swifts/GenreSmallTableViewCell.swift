//
//  GenreSmallTableViewCell.swift
//  Module4Project
//
//  Created by Alvin  on 12/02/2022.
//

import UIKit

class GenreSmallTableViewCell: UITableViewCell {

    var genreList:Array<Genre>?
    {
        didSet
        {
            if let _ = genreList
            {
                self.movieGenreLabelCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var movieGenreLabelCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCells()
        setDataSourceAndDelegate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension GenreSmallTableViewCell
{
    private func setDataSourceAndDelegate()
    {
        movieGenreLabelCollectionView.dataSource = self
        movieGenreLabelCollectionView.delegate = self
    }
    
    private func registerCells()
    {
        movieGenreLabelCollectionView.registerCollectionViewCells(cell: CategoryCollectionViewCell.identifier)
    }
}

extension GenreSmallTableViewCell:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieGenreLabelCollectionView.bindCollectionCellsToYourCollectionView(cell: CategoryCollectionViewCell.identifier, indexPath: indexPath) as CategoryCollectionViewCell
        
        cell.genreCategory = genreList?[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: widthOfCell(content: genreList?[indexPath.row].name ?? "", font: UIFont(name: "Roboto-BoldItalic", size: 17) ?? .systemFont(ofSize: 16) )+50, height: 35)
        
    }
    
    func widthOfCell(content:String,font:UIFont) -> CGFloat
    {
        let textAttribute:Dictionary<NSAttributedString.Key,UIFont> = [
            .font:font
        ]
        
        let sizeOfText = content.size(withAttributes: textAttribute)
        return sizeOfText.width
        
    }
    
}
