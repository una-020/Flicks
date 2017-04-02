    //
//  ViewController.swift
//  Flicks
//
//  Created by Badhri Jagan Sridharan on 3/31/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit
import AFNetworking

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var nowPlayingTable: UITableView!
    @IBOutlet weak var nowPlayingSearchBar: UISearchBar!
    @IBOutlet weak var topRatedTableView: UITableView!
    @IBOutlet weak var nowPlayingScroll: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

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
    
    var isMoreDataLoading = false

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

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
        if(searchActiveInNow) {
            return filtered.count
        }
        return movies.count;
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
            // photos is nil. Good thing we didn't try to unwrap it!
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
       // URL(s)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (!isMoreDataLoading) {
//            // Calculate the position of one screen length before the bottom of the results
//            let scrollViewContentHeight = tableView.contentSize.height
//            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
//            
//            // When the user has scrolled past the threshold, start requesting
//            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
//                isMoreDataLoading = true
//                
//                // ... Code to load more results ...
//            }
//        }
//    }
    
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
