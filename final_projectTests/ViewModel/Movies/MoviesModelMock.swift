//
//  MoviesModelMock.swift
//  final_projectTests
//
//  Created by Jackson on 16/08/22.
//

import Foundation
@testable import final_project

class MoviesModelMock: MoviesModelType {
    var didCalledGetMoviesTimes = 0
    
    func getMovies(completion: @escaping (Data?, Error?) -> Void) {
        didCalledGetMoviesTimes += 1
    }
}
