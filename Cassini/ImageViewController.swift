//
//  ImageViewController.swift
//  Cassini
//
//  Created by Pavel Hrybouski on 14.11.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: NSURL?{
        
        didSet{
             image = nil
            if view.window != nil {
                fetchImage()
            }
            
        }
    }
    
    private func fetchImage (){

        if let url = imageURL {
            spinner?.startAnimating()

            DispatchQueue.global(qos: .userInitiated).async{
                let contentsOfURL = NSData(contentsOf: url as URL )
                DispatchQueue.main.async {
                        if url == self.imageURL{
                            if let imageData = contentsOfURL {
                            self.image = UIImage(data: imageData as Data)
       
                            } else {
                                self.spinner?.stopAnimating()
                            }
                        } else{
                            print("ignored data returned from url\(url)")
                    }
                }
            }
        }
    }
    
    private var imageView = UIImageView()
    private var image: UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            srrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
            if srrollView != nil{
                    var minZoom = min(srrollView.bounds.size.width / imageView.frame.size.width, srrollView.bounds.size.height / imageView.frame.size.height);
                
                    if (minZoom > 1.0) {
                        minZoom = 1.0
                }
                    srrollView.minimumZoomScale = minZoom
            }
 
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var srrollView: UIScrollView!{
        didSet{
            srrollView.contentSize = imageView.frame.size
            srrollView.delegate = self
            srrollView.maximumZoomScale = 1.0
            

        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if image == nil {
            fetchImage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        srrollView.addSubview(imageView)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    


}
