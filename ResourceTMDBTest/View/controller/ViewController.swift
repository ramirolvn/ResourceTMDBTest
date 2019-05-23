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
        let page = self.resultMovies?.lastPage ?? 0
        viewmodel.fetchMovies(page: page + 1)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.fetchMovies()
        }
    }
}
