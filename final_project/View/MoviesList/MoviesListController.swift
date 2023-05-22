//
//  ViewController.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import UIKit

// MARK: - Main Class

class MoviesListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: MoviesViewModel!

    var data: [Movies] {
        return viewModel.model.movies
    }
    
    // MARK: - Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MoviesViewModel(movies: MoviesModel(), service: MoviesService())
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.getMovies()
    }
    
    func didTapCell(position: IndexPath) {
        let id = String(data[position.row].id)
        self.present(MovieDetailsController(movieId: id), animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapCell(position: indexPath)
    }
}
