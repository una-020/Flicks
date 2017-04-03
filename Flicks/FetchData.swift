//
//  FetchData.swift
//  Flicks
//
//  Created by Anusha Kopparam on 4/1/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import Foundation
import UIKit

func fetchMoviesList(fetchURL: String, nowOrTop: Bool, _self: NowPlayingViewController, completion:@escaping (String?,NowPlayingViewController,Bool,String) -> ()) -> Int {
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
                completion("",_self,nowOrTop,"no error")
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
                completion(errorString,_self,nowOrTop,"error")
            }
    });
    task.resume()
                    return returnValue
}

func completionHandler(result: String?, _self: NowPlayingViewController, nowOrTop: Bool, error: String) {
    print(result)
    if(error == "error"){
        if(nowOrTop == true){
            _self.nowPlayingNetworkError.text = "!!Network Error !!"
            _self.nowPlayingNetworkError.alpha = 1.0
        }
        else{
            _self.topRatedNetworkError.text = "!! Network Error !!"
            _self.topRatedNetworkError.alpha = 1.0
        }
    }
    else{
        if(nowOrTop == true){
            _self.nowPlayingNetworkError.text = ""
            _self.nowPlayingNetworkError.alpha = 0.0
        }
        else{
            _self.topRatedNetworkError.text = ""
            _self.topRatedNetworkError.alpha = 0.0
        }
    }
}
