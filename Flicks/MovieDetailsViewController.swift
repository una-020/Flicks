//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Badhri Jagan Sridharan on 4/1/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var posterURL: URL!
    var id: Int!
    var overViewDetails: String!
    var movieTitle: String!
    var movieRelease: String!
    var movieRate: Float!
    //var movieDetails: MovieDetails!
    
    @IBOutlet weak var moviesDetailImageView: UIImageView!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        moviesDetailImageView.setImageWith(posterURL)
       // fetchDataFromWeb()
  
        movieDetailsLabel.text = self.movieTitle
        releaseDateLabel.text = self.movieRelease
        overViewLabel.text = self.overViewDetails
        voteLabel.text = String(format:"%.2f", self.movieRate) // String(describing: self.movieRate)
        runTimeLabel.text = "" //self.movieDetails.runTime as! String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func fetchDataFromWeb(){
//        let url = URL(string:"https://api.themoviedb.org/3/movie/\(self.id)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
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
//                    if let responseDictionary = try! JSONSerialization.jsonObject(
//                        with: data, options:[]) as? NSDictionary {
//                        self.movieDetails.id = responseDictionary["id"] as! Int
//                        self.movieDetails.releaseDate = responseDictionary["release_date"] as! String
//                        self.movieDetails.runTime = responseDictionary["runtime"] as! Int
//                        self.movieDetails.voteAverage = responseDictionary["vote_average"] as! Float
//                        self.movieTitle = responseDictionary["title"] as! String
//                    }
//                }
//        });
//        task.resume()
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
