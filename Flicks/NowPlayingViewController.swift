    //
//  ViewController.swift
//  Flicks
//
//  Created by Badhri Jagan Sridharan on 3/31/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit
import AFNetworking

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet weak var nowPlayingTable: UITableView!
    @IBOutlet weak var nowPlayingSearchBar: UISearchBar!
    @IBOutlet weak var topRatedTableView: UITableView!
    
    
    //var
    //let apiKey = "api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var urlToFetch = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    var movies: [Movie] = []
    var filtered:[Movie] = []
    var selectedIndexForRow:Int? = nil
    var selectedIndexForSection:Int? = nil
    var selectedImageURL:URL!
    var searchActive:Bool = false
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = self.movies.filter({ (movie) -> Bool in return movie.title.contains(searchText)})
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.nowPlayingTable.reloadData()
    }
    
//    func fetchMoviesList(fetchURL: String, nowOrTop: Bool){
//        let url = URL(string: fetchURL)
//        let request = URLRequest(url: url!)
//        let session = URLSession(
//            configuration: URLSessionConfiguration.default,
//            delegate:nil,
//            delegateQueue:OperationQueue.main
//        )
//        let task : URLSessionDataTask = session.dataTask(
//            with: request as URLRequest,
//            completionHandler: { (data, response, error) in
//                if let data = data {
//                    if let resultDictionary = try! JSONSerialization.jsonObject(
//                        with: data, options:[]) as? NSDictionary {
//                        let resultFieldDictionary = resultDictionary["results"] as? NSArray
//                        for result in resultFieldDictionary as! [NSDictionary]{
////                            print(result["backdrop_path"])
////                            print(result["original_title"])
////                            print(result["overview"])
//                            self.movies.append(Movie(jsonResult: result))
//                        }
//                    }
//                }
////                print("nowPlaying: \(self.movies.count)")
//                if( nowOrTop == true){
//                    self.nowPlayingTable.reloadData()
//                    print("nowPlaying: \(self.movies.count)")
//                }
//                else{
//                    self.topRatedTableView.reloadData()
//                    print("topRated: \(self.movies.count)")
//                }
//                //                refreshControl.endRefreshing()
//        });
//        task.resume()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nowPlayingTable.rowHeight = 130.0
        self.nowPlayingTable.dataSource = self
        self.nowPlayingTable.delegate = self
        self.nowPlayingSearchBar.delegate = self
        fetchMoviesList(fetchURL: self.urlToFetch, nowOrTop: true, _self: self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as! MoviesTableViewCell
        let movie: Movie
        
        if(searchActive){
            movie = filtered[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        if let poster = movie.poster  {
            let posterURL = URL(string:"https://image.tmdb.org/t/p/w342/\(poster)")
            cell.moviesImageView.setImageWith(posterURL!)
        } else {
            // photos is nil. Good thing we didn't try to unwrap it!
            cell.moviesImageView.image = nil
        }
        
        cell.movieNameLabel.text = movie.title
        cell.movieNameLabel.adjustsFontSizeToFitWidth = true
        cell.overViewLabel.text = movie.overView
        return cell
    }

}
