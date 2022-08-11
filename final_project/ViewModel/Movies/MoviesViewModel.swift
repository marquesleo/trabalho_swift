//
//  MoviesViewModel.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import Foundation

protocol MoviesViewModelDelegate: AnyObject {
    func getDetails(movieId: Movies)
}

class MoviesViewModel {
    private let model: MoviesModel
    
    weak var delegate: MoviesViewModelDelegate?
    
    var movies: [Movies] = []
    
    init(movies: MoviesModel) {
        self.model = movies
    }
        
    func getMovies() {
        model.getMovies { [weak self] data, error in
            let responseData = try? JSONDecoder().decode(MoviesTopRated.self, from: data!)
            self?.movies = responseData!.results
        }
    }
    
    func getDetails(movieId: String) -> Void {
        // getDetailsMovie()
    }
}

