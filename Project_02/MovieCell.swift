//
//  MovieCell.swift
//  Project_02
//
//  Created by Nam Hoang on 3/6/23.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {
    // Variables that controls the content in the cell
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Given a model movie, configure this cell
    // based on the movie
    func configure(with movie: Movie) {
        // set up the title
        movieTitle.text = movie.title;
        // cut down the description
        movieDescription.text = movie.overview;
        // load the image
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w200/\(movie.poster_path)")!;
        Nuke.loadImage(with: imageUrl, into: moviePoster);
    }

}
