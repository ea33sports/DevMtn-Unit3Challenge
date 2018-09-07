//
//  MovieController.swift
//  Unit3Challenge
//
//  Created by Eric Andersen on 9/7/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class MovieController {
    
    static let shared = MovieController()
    var movies: [Movie] = []
    
    private init() {}
    
    let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    func fetchPosts(by searchTerm: String, completion: @escaping ([Movie]?) -> Void) {
        
        guard let baseURL = MovieController.shared.baseURL else { return }
        let urlParameters = ["query": "\(searchTerm)", "api_key": "074d7884d100516519344f4f61c8bf90"]
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryItems = urlParameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        components?.queryItems = queryItems
        
        guard let url = components?.url else { completion([]); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
                
            if let error = error {
                print("There was an error in \(#function) Error: \(error)")
                completion([]); return
            }
            
            guard let data = data else { completion([]); return }
            let decoder = JSONDecoder()
            
            do {
                let movies = try decoder.decode(MovieDictionary.self, from: data).results
                self.movies = movies
                completion(movies)
              
            } catch let error {
                print("There was an error decoding the json data. Error: \(error) \(error.localizedDescription)")
                completion([]); return
            }
        }.resume()
    }
    
    func fetchImage(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w500/") else { return }
        guard let imageString = movie.image else { return }
        let builtURL = baseURL.appendingPathComponent(imageString)
        print(builtURL)
        URLSession.shared.dataTask(with: builtURL) { (data, _, error) in

            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                let image = UIImage(data: data)
                completion(image)
            } catch let error {
                print("Error fetching image \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            
        }.resume()
    }
}
