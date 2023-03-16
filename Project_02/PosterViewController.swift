//
//  PosterViewController.swift
//  Project_02
//
//  Created by Nam Hoang on 3/15/23.
//

import UIKit
import Nuke

class PosterViewController: UIViewController, UICollectionViewDataSource {
    
    // The data to pass to data source
    var movies: [Movie] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Get the data from an api if there's no data
        
        // Create the URL for the request
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=664b47a8b091af5bd9efe32e32d0add7")!;
        
        // Use the url to create request
        let request = URLRequest(url: url);
        
        // With this request, create a url session by
            // getting a singleton object
            // now, we have the session, we'll do some task (there're 4 types of task)
            // we'll use the dataTask() method -> retrieve the content of a URL
            // we provide a closure(telling what to do when receive data) for the dataTask() method
        let session = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            // Handle errors
            if let error = error {
                print("❌ Network error \(error.localizedDescription)");
            }
            
            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil");
                return;
            }
            
            // Now we have no error, and we have some data.
            // Let's map the response data to our model
            do {
                // create a JSON Decoder
                let decoder = JSONDecoder();
                // now do the decoding job
                let response = try decoder.decode(MovieResponse.self, from: data);
                // try out and see the result
                let movies = response.results;
//                print("From poster view: \(movies)");
                // performing UI update on main thread
                DispatchQueue.main.async {
                    // Set the view controller's tracks property as this is the one the table view references
                    self?.movies = movies;
                    self?.collectionView.reloadData();
                    // testing
                    let myLayout = self?.collectionView.collectionViewLayout as! UICollectionViewFlowLayout;
                    print("after: \(myLayout.itemSize.width)");
                }
                
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)");
            }
        });
        
        // We have the session, now we initiate it
        session.resume();
        
        // set the source
        collectionView.dataSource = self
        
        // Some layout setup
        
        // Get a reference to the collection view's layout
        // We want to dynamically size the cells for the available space and desired number of columns.
        // NOTE: This collection view scrolls vertically, but collection views can alternatively scroll horizontally.
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumInteritemSpacing = 1

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumLineSpacing = 4

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width * 1.5);
        // testing
        print("at first: \(collectionView.bounds.width), \(layout.itemSize.width)");
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get a collection view cell (based in the identifier you set in storyboard) and cast it to our custom AlbumCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCellCollectionViewCell;

        // Use the indexPath.item to index into the albums array to get the corresponding movies
        let movie = movies[indexPath.item]

        // Get the artwork image url
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w300\(movie.poster_path)")!;

        // Set the image on the image view of the cell
        Nuke.loadImage(with: imageUrl, into: cell.ImageViewCell)
        
//        // some testing
//        let imageView = cell.ImageViewCell!;
//        imageView.layer.masksToBounds = true;
//        imageView.layer.borderWidth = 1.5;
//        imageView.layer.borderColor = UIColor.green.cgColor
//        // some testing
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "posterSegue" {
            // Get the cell that triggered the segue
            if let cell = sender as? PosterCellCollectionViewCell,
                // get the index of the particular cell
                let indexPath = collectionView.indexPath(for: cell),
                // based on indexPath, we get the row, or the indexes of the arry
                // now set up the movie on the destination
                let destination = segue.destination as? DetailViewController {
                    // craft the according movie based on the indexPath
                    let movie = movies[indexPath.row];
                    // set the property of the destination
                    destination.movie = movie;
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
