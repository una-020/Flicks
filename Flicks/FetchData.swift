//
//  FetchData.swift
//  Flicks
//
//  Created by Anusha Kopparam on 4/1/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import Foundation
import UIKit

func fetchMoviesList(fetchURL: String, nowOrTop: Bool, _self: NowPlayingViewController) -> Int {
    let url = URL(string: fetchURL)
    let request = URLRequest(url: url!)
    var returnValue = 0
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
                        _self.movies.append(Movie(jsonResult: result))
                    }
                }
            }
            if(nowOrTop == true){
                _self.nowPlayingTable.reloadData()
            }
            else{
                _self.topRatedTableView.reloadData()
            }
            if let error = error
            {
                let  errorString:String = String(describing: error)
                errorString.contains("The Internet connection appears to be offline.")
                returnValue = 100
                if(nowOrTop == true){
                    _self.nowPlayingTable.reloadData()
                    if(returnValue > 0) {
                        _self.nowPlayingNetworkError.text = "!! Network Error !!"
                    }
                    else {
                        _self.nowPlayingNetworkError.text = ""
                    }
                    
                }
                else{
                    _self.topRatedTableView.reloadData()
                    if(returnValue > 0) {
                        _self.topRatedNetworkError.text = "!! Network Error !!"
                    }
                    else {
                        _self.topRatedNetworkError.text = ""
                    }
                    
                }

            }
    });
    task.resume()
                    return returnValue
}
