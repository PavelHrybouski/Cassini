//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Pavel Hrybouski on 14.11.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {

    private struct StoryBoard {
        static let ShowImageSegue = "Show Image"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.ShowImageSegue {
            
            if let ivc = segue.destination.contentViewController as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageName(imageName: imageName)
                ivc.title = imageName
            }
        }
    }

    @IBAction func showImage(_ sender: UIButton) {
        
            if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController{
                let imageName = sender.currentTitle
                ivc.imageURL = DemoURL.NASAImageName(imageName: imageName)
                ivc.title = imageName
            } else{
                performSegue(withIdentifier: StoryBoard.ShowImageSegue, sender: sender)
            }
        }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController{
            if ivc.imageURL == nil{
                return true
            }
        }
    
        return false

    }
    
}

extension UIViewController{
    var contentViewController: UIViewController{
    if let nav = self as? UINavigationController {
       return nav.visibleViewController ?? self
    } else{
        return self
        }
}
}
