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
    
    // Variable that represent table view
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // initialize the list of movies
        movies = mockData()!;
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {
            // Deselect the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

