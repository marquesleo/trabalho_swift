//
//  MovieDetails.swift
//  final_project
//
//  Created by Jackson on 16/08/22.
//

import Foundation

class MovieDetailsViewModel {
    var movie: MovieDetails?
    var model: MovieDetailsModel
    
    var updateMovieDetails: (() -> Void)?
    
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    
    init(model: MovieDetailsModel) {
        self.model = model
    }
    
    func fetchMovie(movieId: String) {
        self.showLoading?()
        model.getDetails(movieId: movieId, completion: { [weak self] data, error in
            let responseData = try? JSONDecoder().decode(MovieDetails.self, from: data!)
            self?.movie = responseData
            self?.updateMovieDetails?()
            self?.hideLoading?()
        })
    }
}
