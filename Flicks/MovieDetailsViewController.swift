//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Anusha Kopparam on 4/1/17.
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
    
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        startIndicator()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        startIndicator()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        indicator.stopAnimating()
    }

    override func viewDidLoad() {
        startIndicator()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        moviesDetailImageView.setImageWith(posterURL)
  
        movieDetailsLabel.text = self.movieTitle
        releaseDateLabel.text = self.movieRelease
        overViewLabel.text = self.overViewDetails
        voteLabel.text = String(format:"%.2f", self.movieRate)
        runTimeLabel.text = ""
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
