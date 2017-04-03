    //
//  ViewController.swift
//  Flicks
//
//  Created by Anusha Kopparam on 3/31/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit
import AFNetworking
//import  S
class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UIScrollViewDelegate {
    
    let refreshControlUI = UIRefreshControl()

    @objc func refreshControlAction() {
        let networkStatus = fetchMoviesList(fetchURL: self.urlToFetch, nowOrTop: true, _self: self, completion: completionHandler)
        refreshControlUI.endRefreshing()
    }


    @IBOutlet weak var nowPlayingNetworkError: UILabel!
    @IBOutlet weak var nowPlayingTable: UITableView!
    @IBOutlet weak var nowPlayingSearchBar: UISearchBar!
    @IBOutlet weak var topRatedTableView: UITableView!
    @IBOutlet weak var topRatedNetworkError: UILabel!
    
    
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    
    var urlToFetch = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    var movies: [Movie] = []
    var filtered:[Movie] = []
    
    var selectedIndexForRow:Int? = nil
    var selectedIndexForSection:Int? = nil
    var selectedImageURL:URL!
    
    var selectedId:Int!
    var selectedOverview:String!
    var selectedMovie:String!
    var selectedRelease:String = ""
    var selectedVote:Float = 0.0
    
    var searchActiveInNow:Bool = false
    var countOfMovies = 0
    var isMoreDataLoading = false
    
    var networkStatus = 0

    var progressMovies:UIActivityIndicatorView!
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActiveInNow = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActiveInNow = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActiveInNow = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActiveInNow = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = self.movies.filter({ (movie) -> Bool in return movie.title.contains(searchText)})
        if(filtered.count == 0){
            searchActiveInNow = false;
        } else {
            searchActiveInNow = true;
        }
        self.nowPlayingTable.reloadData()
    }
    
    func startIndicator()
    {
        indicator.color = UIColor.red
        indicator.frame = CGRect(x:0.0, y:0.0, width: 100, height:100)
        indicator.center = self.view.center
        indicator.transform =  CGAffineTransform(scaleX: 3, y: 3)

        self.view.addSubview(indicator)
        indicator.bringSubview(toFront: self.view)
        indicator.startAnimating()
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        startIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        indicator.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        startIndicator()

        self.navigationController?.setNavigationBarHidden(true, animated: true)

        networkStatus = fetchMoviesList(fetchURL: self.urlToFetch, nowOrTop: true, _self: self, completion: completionHandler)

//        if (networkStatus > 0) {
//            nowPlayingNetworkError.text = "!! Network Error!!"
//        }
//        else {
//            nowPlayingNetworkError.text = ""
//        }

        
        self.nowPlayingTable.rowHeight = 130.0
        self.nowPlayingTable.dataSource = self
        self.nowPlayingTable.delegate = self
        self.nowPlayingSearchBar.delegate = self
        self.nowPlayingTable.isScrollEnabled = true

        refreshControlUI.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        nowPlayingTable.insertSubview(refreshControlUI, at: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActiveInNow) {
            countOfMovies = filtered.count
        }
        else {
            countOfMovies = movies.count
        }
        return countOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as! MoviesTableViewCell
        let movie: Movie
        
        if(searchActiveInNow){
            movie = filtered[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        if let poster = movie.poster  {
            let posterURL = URL(string:"https://image.tmdb.org/t/p/w342/\(poster)")
            cell.moviesImageView.setImageWith(posterURL!)
        } else {
            cell.moviesImageView.image = nil
        }
        
        cell.movieNameLabel.text = movie.title
        cell.movieNameLabel.adjustsFontSizeToFitWidth = true
        cell.overViewLabel.text = movie.overView
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let movie: Movie
        if(searchActiveInNow){
            movie = filtered[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }

        self.selectedIndexForRow = indexPath.row
        self.selectedIndexForSection = indexPath.section
        
        if let poster = movie.poster  {
            let posterURL = URL(string:"https://image.tmdb.org/t/p/w342/\(poster)")
            self.selectedImageURL = posterURL
            self.selectedId = movie.id
            self.selectedOverview = movie.overView
            self.selectedMovie = movie.title
            self.selectedVote = movie.voteAverage
            self.selectedRelease = movie.releaseDate
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieDetailsViewController
        vc.posterURL = self.selectedImageURL
        vc.id = self.selectedId
        vc.overViewDetails = self.selectedOverview
        vc.movieTitle = self.selectedMovie
        vc.movieRelease = self.selectedRelease
        vc.movieRate = self.selectedVote
    }
}
