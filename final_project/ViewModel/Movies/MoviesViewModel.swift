//
//  MoviesViewModel.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import Foundation

class MoviesViewModel {
    private let model: MoviesModelType
    
    var movies: [Movies] = []
    
    init(movies: MoviesModelType) {
        self.model = movies
    }
        
    func getMovies() {
        model.getMovies { [weak self] data, error in
            let responseData = try? JSONDecoder().decode(MoviesTopRated.self, from: data!)
            self?.movies = responseData!.results
        }
    }
}

