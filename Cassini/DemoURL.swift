//
//  DemoURL.swift
//  Cassini
//
//  Created by Pavel Hrybouski on 14.11.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

import Foundation
struct DemoURL {
    static let Stanford = "http://comm.stanford.edu//mm/2013/02/mcclatchy-hall.jpg"
   
    static let NASA = [
    "Cassini":"http://comm.stanford.edu//mm/2013/02/mcclatchy-hall.jpg",
    "Earth":"http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
    "Saturn":"http://www.nasa.gov/sites/default/files/saturn_collage.jpg"]
    
    static func NASAImageName(imageName: String?) -> NSURL?{
        if let urlString = NASA [imageName ?? ""]{
            return NSURL(string: urlString)
        }else{
            return nil
        }
    }
}
//http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg
