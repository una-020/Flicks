//
//  TopRatedViewController.swift
//  Flicks
//
//  Created by Badhri Jagan Sridharan on 3/31/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit

//private let apiKey = "api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
//private let topRatedURL = "https://api.themoviedb.org/3/movie/top_rated?\(apiKey)"

class TopRatedViewController: NowPlayingViewController {

    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var topRatedSearchBar: UISearchBar!
    
    var topToFetch = "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var topMovies: [Movie] = []
    var searchActiveInTop: Bool = false
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = self.movies.filter({ (movie) -> Bool in return movie.title.contains(searchText)})

        if(filtered.count == 0){
            searchActiveInNow = false;
        } else {
            searchActiveInNow = true;
        }
        //print("Inside TopRated searchBar. Matching is \(filtered.count)")
        self.topTableView.reloadData()
    }

    override func viewDidLoad() {
        self.topTableView.rowHeight = 130.0
        self.topTableView.dataSource = self
        self.topTableView.delegate = self
        self.topRatedSearchBar.delegate = self
        fetchMoviesList(fetchURL: topToFetch, nowOrTop: false, _self: self)
        //print(topMovies[0].title)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
