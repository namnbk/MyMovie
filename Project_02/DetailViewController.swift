//
//  DetailViewController.swift
//  Project_02
//
//  Created by Nam Hoang on 3/6/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    // instance variable that represent a movie
    var movie: Movie!
    
    // Movie poster and movie title
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailPoster: UIImageView!
    
    // Some information about the movie's popularity
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var popularity: UILabel!
    
    // An overview about the movie
    @IBOutlet weak var detailDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Push the information from the instance variable to the screen
        detailTitle.text = movie.title;
        // Image
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(movie.backdrop_path)")!;
        Nuke.loadImage(with: imageUrl, into: detailPoster)
        // The information
        voteAverage.text = "\(movie.vote_average) vote average";
        voteCount.text = "\(movie.vote_count) votes";
        popularity.text = "\(movie.popularity) popularity";
        // Overview
        detailDescription.text = movie.overview;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "similarSegue" {
            if let destination = segue.destination as? HomeViewController {
               // change the url request
                destination.urlString = "https://api.themoviedb.org/3/movie/\(self.movie.id)/similar?api_key=664b47a8b091af5bd9efe32e32d0add7"
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
