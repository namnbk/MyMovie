//
//  ViewController.swift
//  Project_02
//
//  Created by Nam Hoang on 3/6/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    // The data to pass to data source
    var movies: [Movie] = []
    var urlString:String = ""
    
    // Variable that represent table view
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize the URL string for the request if the there's no URL string yet
        if urlString == "" {
            urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=664b47a8b091af5bd9efe32e32d0add7"
        }
        
        // Get the data from an api by first creating a URL 
        let url = URL(string: urlString)!;
        
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
//                print("From movies view: \(movies)");
                // performing UI update on main thread
                DispatchQueue.main.async {
                    // Set the view controller's tracks property as this is the one the table view references
                    self?.movies = movies;
                    // Reload the table view when having new data
                    self?.tableView.reloadData();
                }
                
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)");
            }
        });
        
        // We have the session, now we initiate it
        session.resume();
        
        // configure this class to be the datasource for table view
        tableView.dataSource = self;
        // enable auto height in cell
        tableView.rowHeight = UITableView.automaticDimension;
    }
    
    // Act as a datasource for table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // take a cell out for rendering and returning later
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell;
        // get the data at correct position
        let movie = movies[indexPath.row];
        // configure the cell with data from movie and return 
        cell.configure(with: movie);
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moviesSegue" {
            // Get the cell that triggered the segue
            if let cell = sender as? MovieCell,
                // get the index of the particular cell
                let indexPath = tableView.indexPath(for: cell),
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {
            // Deselect the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

