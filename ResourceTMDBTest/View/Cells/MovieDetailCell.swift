//
//  MovieDetailCell.swift
//  ResourceTMDBTest
//
//  Created by Ramiro Lima Vale Neto on 23/05/19.
//  Copyright © 2019 Vikram Gupta. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateView(withMovie movie: Movie){
        self.rateLbl.text = "Vote Average: \(movie.vote_average)"
        self.dateLbl.text = "Release Date: \(movie.release_date?.formattedDate ?? "-")"
        self.genreLbl.text = "Genre: \(movie.genre ?? "-")"
        
        
        self.overviewLbl.text = "Original Title: \(movie.original_title) \n\(movie.overview)"
        
        movieImg.sd_setShowActivityIndicatorView(true)
        movieImg.sd_setIndicatorStyle(.gray)
        movieImg.sd_setImage(with: URL(string: movie.poster_pathURL), placeholderImage:nil)
    }
    
}
