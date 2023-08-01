//
//  MoviesListControllerTests.swift
//  final_projectTests
//
//  Created by Leonardo Marques on 31/07/23.
//
import Foundation
import XCTest

@testable import final_project

class MoviesListControllerTests: XCTestCase {
    var sut: MoviesListController!
    var viewModel: MoviesViewModelMock!
    
    
    override func setUp() {
        viewModel = MoviesViewModelMock(model:MoviesModelMock(), service:MoviesServiceMock())
        
        
        sut = MoviesListController()
        sut.viewModel = viewModel
        
    }
    
    
    func test_shouldCallViewModel_when_ViewDidLoad(){
        sut.viewDidLoad()
        
        XCTAssertTrue(viewModel.didCalledGetMovies >= 1)
    }
}
