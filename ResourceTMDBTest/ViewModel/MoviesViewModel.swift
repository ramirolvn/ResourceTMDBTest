import Foundation
class MoviesViewModel {
    private(set) public var error: String?
    private(set) public var resultMovies: ResultMovies? {
        didSet {
            self.didFinishFetch?()
        }
    }
    private(set) public var selectedMovie: Movie? {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    private var dataService: DataService
    var didFinishFetch: (() -> ())?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func fetchMovies(currentResultMovies: ResultMovies?) {
        let currentPage = currentResultMovies?.lastPage ?? 0
        let nextPage = currentPage+1
        if let maxPages = currentResultMovies?.total_pages, maxPages < nextPage{
            self.error = nil
            self.resultMovies = currentResultMovies!
        }else{
            dataService.fetchMovies(page: nextPage, completion: {
                (result, error) in
                if let e = error{
                    self.error = e
                    self.resultMovies = nil
                }else{
                    self.error = nil
                    if nextPage == 1 {self.resultMovies = result! }else{
                        //updateResult -- Depois fazer uma classe de manejo do model
                        self.resultMovies = ResultMovies(resultAntigo: self.resultMovies!, resultAtual: result!)
                    }
                    
                }
            })
        }
    }
    
    func fetchMovie(movieID: Int) {
        dataService.fetchSpecificMovie(movieID: movieID, completion: {
            (movie, error) in
            if let e = error{
                self.error = e
                self.selectedMovie = nil
            }else{
                self.error = nil
                self.selectedMovie = movie!
            }
        })
    }
}
