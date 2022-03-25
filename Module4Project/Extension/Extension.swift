//
//  Extension.swift
//  Module4Project
//
//  Created by Alvin  on 09/02/2022.
//

import Foundation
import UIKit

extension UITableViewCell
{
    static var identifier:String
    {
        String(describing: self)
    }
}

extension UITableView
{
    public func registerTableViewCells(cell identifer:String)
    {
        register(UINib(nibName: identifer, bundle: nil), forCellReuseIdentifier: identifer)
    }
    
    public func bindTableViewCellsToYourTableView<T:UITableViewCell>(cell identifer:String, indexPath:IndexPath) -> T
    {
        guard let cell = dequeueReusableCell(withIdentifier: identifer, for: indexPath) as? T else
        {
            return UITableViewCell() as! T
        }
       return cell
    }
}

extension UICollectionViewCell
{
    static var identifier:String
    {
        String(describing: self)
    }
    
}

extension UICollectionView
{
    public func registerCollectionViewCells(cell identifier:String)
    {
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    public func bindCollectionCellsToYourCollectionView<C:UICollectionViewCell>(cell identifier:String,indexPath:IndexPath) -> C
    {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? C else {
            return UICollectionViewCell() as! C
        }
        return cell
    }
    
}

extension UILabel
{ 
    func returnAttributedString(text:String) -> NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString.init(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        return attributedString
    }
}

