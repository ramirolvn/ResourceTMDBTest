//
//  MovieDetailController.swift
//  ResourceTMDBTest
//
//  Created by Ramiro Lima Vale Neto on 23/05/19.
//  Copyright © 2019 Vikram Gupta. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailController: UIViewController {
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.movie.title
        self.rateLbl.text = "Nota: \(movie.vote_average ?? 0.0)"
        self.genreLbl.text = "Gênero: \(movie.genre ?? "-")"
        self.dateLbl.text = "Data: \(movie.release_date?.formattedDate ?? "-")"
        
        self.overviewLbl.text = movie.overview
        
        movieImg.sd_setShowActivityIndicatorView(true)
        movieImg.sd_setIndicatorStyle(.gray)
        movieImg.sd_setImage(with: URL(string: movie.poster_pathURL), placeholderImage:nil)
        
    }
    
}
