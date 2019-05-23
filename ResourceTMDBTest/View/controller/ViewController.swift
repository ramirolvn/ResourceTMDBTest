import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    private var resultMovies: ResultMovies?
    private var filtredMovies: [Movie]?
    var user: User!
    
    private var viewmodel = MoviesViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Welcome \(self.user.username)"
        searchBar.delegate = self
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        fetchMovies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieCell, let movie = self.filtredMovies?[indexPath.row] {
            cell.updateView(withMovie: movie)
            return cell
        } else {
            return MovieCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = self.filtredMovies?[indexPath.row]{
            self.loading()
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
            if self.resultMovies?.lastPage != self.resultMovies?.total_pages && self.filtredMovies?.count == self.resultMovies?.movies.count{
                self.fetchMovies()
            }
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        self.loading()
        viewmodel.logout(currentUser: self.user)
        self.dismissLoading()
        if let e = self.viewmodel.error{
            self.presentAlertWithTitle(title: "Atenção", message: e, options: "Ok", completion: {_ in})
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "initialNav") as! UINavigationController
            appDelegate.window?.rootViewController = mainNav
        }
    }
    
    private func fetchMovies() {
        self.loading()
        viewmodel.fetchMovies(currentResultMovies: self.resultMovies)
        viewmodel.didFinishFetch = {
            self.dismissLoading()
            self.resultMovies = self.viewmodel.resultMovies!
            self.filtredMovies = Array(self.viewmodel.resultMovies!.movies)
            self.moviesTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let movies = self.resultMovies?.movies{
            filtredMovies = searchText.isEmpty ?  Array(movies) :  Array(movies).filter({ $0.original_title.lowercased().contains(searchText.lowercased())})
        }
        moviesTableView.reloadData()
    }
    
}
