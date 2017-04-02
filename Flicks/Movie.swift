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
    var id: Int
    
    init(jsonResult: NSDictionary) {
        if let posterURL = jsonResult["backdrop_path"] as? String {
            self.poster = posterURL
        }
        else{
            self.poster = nil
        }
        self.title = jsonResult["original_title"] as! String
        self.overView = jsonResult["overview"] as! String
        self.id = jsonResult["id"] as! Int
    }
}

class MovieDetails{

    var id: Int
    var releaseDate: String
    var runTime: Int?
    var voteAverage: Float
    
    init(jsonResult: NSDictionary) {
        self.id = jsonResult["id"] as! Int
        self.releaseDate = jsonResult["release_date"] as! String
        self.runTime = jsonResult["runtime"] as! Int
        self.voteAverage = jsonResult["vote_average"] as! Float
    }
}
