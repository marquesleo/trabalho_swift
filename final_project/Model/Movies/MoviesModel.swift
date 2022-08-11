//
//  ViewControllerModel.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import Foundation


class MoviesModel {
    func getMovies(completion: @escaping (Data?, Error?) -> Void) -> Void {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=828ce092ac14611725ef303e95efd77d")!, completionHandler: { (data, response, error) in
            completion(data, error)
        }).resume()
    }
}
