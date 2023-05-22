//
//  ViewControllerModel.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import Foundation

protocol MoviesModelType {
    var movies: [Movies] { get set }
}


class MoviesModel: MoviesModelType {
    var movies: [Movies] = []
}
