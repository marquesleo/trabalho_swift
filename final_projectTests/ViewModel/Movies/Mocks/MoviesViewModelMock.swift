//
//  MoviesViewModelMock.swift
//  final_projectTests
//
//  Created by Leonardo Marques on 31/07/23.
//

import Foundation
@testable import final_project

class MoviesViewModelMock: MoviesViewModelType {
    
    required init(model:MoviesModelType, service:MoviesServiceType){
        self.model = model
        self.service = service
        
        didCalledInitTimes += 1
    }
    
    var model: MoviesModelType
    var service: MoviesServiceType
    var reloadTable: (() -> Void)?
    
    var didCalledInitTimes = 0
    var didCalledGetMovies = 0
       
    
    func getMovies() {
        self.didCalledGetMovies += 1
        
    }
}
