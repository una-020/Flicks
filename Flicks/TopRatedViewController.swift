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
    
    var topToFetch = "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var topMovies: [Movie] = []
    var searchActiveInTop: Bool = false
    
    
//    override func fetchMoviesList(fetchURL: String){
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
//                            self.topMovies.append(Movie(jsonResult: result))
//                        }
//                    }
//                }
//                    print("TopRatedViewController: \(self.topMovies.count)")
//                    self.topTableView.reloadData()
//                //                refreshControl.endRefreshing()
//        });
//        task.resume()
//    }

    override func viewDidLoad() {
        self.topTableView.rowHeight = 130.0
        self.topTableView.dataSource = self
        self.topTableView.delegate = self
        fetchMoviesList(fetchURL: topToFetch, nowOrTop: false, _self: self)
        //print(topMovies[0].title)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(searchActiveInTop){
//            return filtered.count}
//        return topMovies.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //var cell = UITableViewCell() //tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as! MoviesTableViewCell
//        
//        var cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as! MoviesTableViewCell
//        let movie: Movie
//        
//        if(searchActiveInTop){
//            movie = filtered[indexPath.row]
//        } else {
//            movie = topMovies[indexPath.row]
//        }
//
////        cell.textLabel?.text = movie.title
////        print(movie.title)
//        if let poster = movie.poster  {
//            let posterURL = URL(string:"https://image.tmdb.org/t/p/w342/\(poster)")
//            cell.moviesImageView.setImageWith(posterURL!)
//        } else {
//            // photos is nil. Good thing we didn't try to unwrap it!
//            cell.moviesImageView.image = nil
//        }
//        
//        cell.movieNameLabel.text = movie.title
//        cell.movieNameLabel.adjustsFontSizeToFitWidth = true
//        cell.overViewLabel.text = movie.overView
//        return cell
//    }
//    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
