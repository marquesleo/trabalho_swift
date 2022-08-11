//
//  ViewController.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import UIKit

// MARK: - Main Class

class MoviesController: UIViewController, UITableViewDataSource, UITableViewDelegate, MoviesViewModelDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: MoviesViewModel!

    var data: [Movies] {
        return viewModel.movies
    }
    
    // MARK: - Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MoviesViewModel(movies: MoviesModel())
        
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.getMovies()
    }
    
    
    // MARK: - Data source methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = self.data[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}


// MARK: - View Model Delegate Methods

extension MoviesViewModelDelegate {
    func getDetails(movieId: Movies) {
        // TODO implement
    }
}
