//
//  Movie.swift
//  Project_02
//
//  Created by Nam Hoang on 3/6/23.
//

import Foundation

// This is a struct for the movie model
struct Movie: Decodable {
    let title: String
    let overview: String
    let poster_path: String
    let backdrop_path: String
    let popularity: Double
    let vote_average: Double
    let vote_count: Int
    let id: Int
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
