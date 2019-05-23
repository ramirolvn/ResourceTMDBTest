//
//  MovieDetailController.swift
//  ResourceTMDBTest
//
//  Created by Ramiro Lima Vale Neto on 23/05/19.
//  Copyright © 2019 Vikram Gupta. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var movieDetailTable: UITableView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.movie.title
        self.movieDetailTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let detailMovieCell = self.movieDetailTable.dequeueReusableCell(withIdentifier: "movieDetail") as? MovieDetailCell{
            detailMovieCell.updateView(withMovie: self.movie)
            cell = detailMovieCell
        }
        return cell
    }
    
    
    
}
