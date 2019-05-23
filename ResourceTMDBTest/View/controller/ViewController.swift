import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moviesTableView: UITableView!
    private var resultMovies: ResultMovies?
    var user: User!
    
    private var viewmodel = MoviesViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Bem vindo \(self.user.username)"
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        fetchMovies()
    }
    
    private func fetchMovies() {
        self.loading(nil)
        viewmodel.fetchMovies(currentResultMovies: self.resultMovies)
        viewmodel.didFinishFetch = {
            self.dismissLoading()
            self.resultMovies = self.viewmodel.resultMovies!
            self.moviesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultMovies?.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieCell, let movie = self.resultMovies?.movies?[indexPath.row] {
            cell.updateView(withMovie: movie)
            return cell
        } else {
            return MovieCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = self.resultMovies?.movies?[indexPath.row]{
            self.loading("Carregando informações do filme")
            viewmodel.fetchMovie(movieID: movie.id)
            viewmodel.didFinishFetch = {
                self.dismissLoading()
                if let e = self.viewmodel.error{
                    self.presentAlertWithTitle(title: "Atenção", message: e, options: "Ok", completion: {_ in})
                }else if let movieDetail = self.storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? MovieDetailController{
                    movieDetail.movie = self.viewmodel.selectedMovie!
                    self.navigationController?.pushViewController(movieDetail, animated: true)
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.section == 0 && indexPath.row == lastRowIndex {
            if self.resultMovies?.lastPage != self.resultMovies?.total_pages{
                self.fetchMovies()
            }
        }
    }
}
