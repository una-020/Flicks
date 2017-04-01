//
//  Movie.swift
//  Flicks
//
//  Created by Badhri Jagan Sridharan on 4/1/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import Foundation
class Movie{
    var poster: String?
    var title: String
    var overView: String
    
    
    init(jsonResult: NSDictionary) {
        if let posterURL = jsonResult["backdrop_path"] as? String {
            self.poster = posterURL
        }
        else{
            self.poster = nil
        }
        self.title = jsonResult["original_title"] as! String
        self.overView = jsonResult["overview"] as! String
    }
}
