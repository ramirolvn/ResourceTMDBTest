import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var moviePhoto: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateView(withMovie movie: Movie) {
        self.name.text = movie.original_title
        self.movieRate.text = "\(movie.vote_average)" == "0.0" ? "-" : "\(movie.vote_average)"
        moviePhoto.sd_setShowActivityIndicatorView(true)
        moviePhoto.sd_setIndicatorStyle(.gray)
        moviePhoto.sd_setImage(with: URL(string: movie.poster_pathURL), placeholderImage:nil)
    }
}
