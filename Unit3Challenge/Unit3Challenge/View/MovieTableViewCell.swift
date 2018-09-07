//
//  MovieTableViewCell.swift
//  Unit3Challenge
//
//  Created by Eric Andersen on 9/7/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overViewTextField: UITextView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    func updateViews() {
        
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.rating)"
        overViewTextField.text = movie.overview
        MovieController.shared.fetchImage(movie: movie) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
}
