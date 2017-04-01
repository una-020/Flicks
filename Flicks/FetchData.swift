//
//  FetchData.swift
//  Flicks
//
//  Created by Badhri Jagan Sridharan on 4/1/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import Foundation
import UIKit

func fetchMoviesList(fetchURL: String, nowOrTop: Bool, _self: NowPlayingViewController){
    let url = URL(string: fetchURL)
    let request = URLRequest(url: url!)
    let session = URLSession(
        configuration: URLSessionConfiguration.default,
        delegate:nil,
        delegateQueue:OperationQueue.main
    )
    let task : URLSessionDataTask = session.dataTask(
        with: request as URLRequest,
        completionHandler: { (data, response, error) in
            if let data = data {
                if let resultDictionary = try! JSONSerialization.jsonObject(
                    with: data, options:[]) as? NSDictionary {
                    let resultFieldDictionary = resultDictionary["results"] as? NSArray
                    for result in resultFieldDictionary as! [NSDictionary]{
                        //                            print(result["backdrop_path"])
                        //                            print(result["original_title"])
                        //                            print(result["overview"])
                        _self.movies.append(Movie(jsonResult: result))
                    }
                }
            }
            //                print("nowPlaying: \(self.movies.count)")
            if( nowOrTop == true){
                _self.nowPlayingTable.reloadData()
              //  print("nowPlaying: \(_self.movies.count)")
            }
            else{
                _self.topRatedTableView.reloadData()
                //print("topRated: \(_self.movies.count)")
            }
            //                refreshControl.endRefreshing()
    });
    task.resume()
}
