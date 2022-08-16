//
//  final_projectTests.swift
//  final_projectTests
//
//  Created by Jackson on 16/08/22.
//

import XCTest
@testable import final_project

class final_projectTests: XCTestCase {
    
    
    func testExample() throws {
        let model = MoviesModelMock()
        let viewModel = MoviesViewModel(movies: model)
        
        viewModel.getMovies()
        
        XCTAssert(model.didCalledGetMoviesTimes == 1)
    }
}
