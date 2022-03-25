//
//  Navigation.swift
//  Module4Project
//
//  Created by Alvin  on 12/02/2022.
//

import Foundation
import UIKit

enum StoryBoards:String
{
    case main = "Main"
    case LaunchScreen = "LaunchScreen"
}

extension UIViewController
{
    static var identifier:String
    {
        String(describing: self)
    }
}

extension UIStoryboard
{
    static func makeANewStoryBoard<S:UIStoryboard>(storyBoardName:String) -> S
    {
        guard let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil) as? S else
        {
            return UIStoryboard() as! S
        }
        return storyBoard
    }
}

extension UIViewController
{
     public func navigateToMovieDetailViewController()
    {
        let storyBoard = UIStoryboard.makeANewStoryBoard(storyBoardName: StoryBoards.main.rawValue)
        guard let vc = storyBoard.instantiateViewController(withIdentifier:MovieDetailViewController.identifier) as? MovieDetailViewController else {
            debugPrint("empty vc")
            return
        }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
       present(vc, animated: true, completion: nil)
       
        
        
    }
}
