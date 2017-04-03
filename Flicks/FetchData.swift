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
               // print(errorString)
                if(nowOrTop == true){
                    _self.nowPlayingTable.reloadData()
                    if(returnValue > 0) {
                        //_self.nowPlayingNetworkError.isHidden = false
                        _self.nowPlayingNetworkError.text = "!! Network Error !!"
                    }
                    else {
                        //_self.nowPlayingNetworkError.isHidden = true
                        _self.nowPlayingNetworkError.text = ""
                    }
                    
                }
                else{
                    _self.topRatedTableView.reloadData()
                    if(returnValue > 0) {
                        //_self.topRatedNetworkError.isHidden = false
                        _self.topRatedNetworkError.text = "!! Network Error !!"
                    }
                    else {
//                        _self.topRatedNetworkError.isHidden = true
                        _self.topRatedNetworkError.text = ""
                    }
                    
                }

            }
    });
    task.resume()
                    return returnValue
}
//
//class InfiniteScrollActivityView: UIView {
//    
//    var loadingIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
//    
//    static let defaultHeight:CGFloat = 60.0
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupActivityIndicator()
//    }
//    
//    override init(frame aRect: CGRect) {
//        super.init(frame: aRect)
//        setupActivityIndicator()
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        loadingIndicatorView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
//        loadingIndicatorView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
//        loadingIndicatorView.transform = CGAffineTransform(scaleX: 3, y: 3)
//    }
//    
//    func setupActivityIndicator() {
//        loadingIndicatorView.activityIndicatorViewStyle = .gray
//        loadingIndicatorView.sizeToFit()
//        loadingIndicatorView.hidesWhenStopped = true
//        self.addSubview(loadingIndicatorView)
//    }
//    
//    func stopAnimating() {
//        self.loadingIndicatorView.stopAnimating()
//        self.isHidden = true
//    }
//    
//    func startAnimating() {
//        self.isHidden = false
//        self.loadingIndicatorView.startAnimating()
//    }
//}
//

