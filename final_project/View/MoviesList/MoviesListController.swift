//
//  ViewController.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import UIKit

// MARK: - Main Class

class MoviesListController: UIViewController, Coordinating, UITableViewDataSource, UITableViewDelegate {
    var coordinator: Coordinator?
    
    private var tableView: UITableView = {
        let table =  UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var viewModel: MoviesViewModel!

    private var data: [Movies] {
        return viewModel.model.movies
    }
    
    // MARK: - Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupContraints()
        
        bindSetup()
        
        viewModel.getMovies()
    }
    
    func bindSetup() {
        viewModel = MoviesViewModel(movies: MoviesModel(), service: MoviesService())
        viewModel.reloadTable = self.reloadTable
    }
    
    func setupContraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
    }
    
    func didTapCell(position: IndexPath) {
        let id = String(data[position.row].id)
        // add coordinator
        self.present(MovieDetailsController(movieId: id), animated: true)
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
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
