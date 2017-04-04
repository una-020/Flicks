//
//  TopRatedViewController.swift
//  Flicks
//
//  Created by Anusha Kopparam on 3/31/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit

class TopRatedViewController: NowPlayingViewController {

    @IBOutlet weak var NetworkErrorLabel: UILabel!
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var topRatedSearchBar: UISearchBar!
    
    
    @objc override func refreshControlAction() {
        fetchMoviesList(fetchURL: topToFetch, nowOrTop: false, _self: self, completion: completionHandler)
        refreshControlUI.endRefreshing()
    }
    
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
        self.topTableView.reloadData()
    }

    override func viewDidLoad() {
        self.topTableView.rowHeight = 130.0
        self.topTableView.dataSource = self
        self.topTableView.delegate = self
        self.topRatedSearchBar.delegate = self

        topRatedSearchBar.isHidden = false
        self.topTableView.tableHeaderView = self.topRatedSearchBar

        networkStatus = fetchMoviesList(fetchURL: topToFetch, nowOrTop: false, _self: self, completion: completionHandler)

        refreshControlUI.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        topTableView.insertSubview(refreshControlUI, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topRatedSearchBar.isHidden = false
        //topRatedSearchBar.barPosition
        self.view.bringSubview(toFront: topRatedSearchBar)
        startIndicator()
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
