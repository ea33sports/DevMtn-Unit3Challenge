//
//  Movie.swift
//  Unit3Challenge
//
//  Created by Eric Andersen on 9/7/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

struct MovieDictionary: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let rating: Double
    let overview: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case rating = "vote_average"
        case overview = "overview"
        case image = "poster_path"
    }
}


