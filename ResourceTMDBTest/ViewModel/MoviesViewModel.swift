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
        dataService.fetchMovies(page: nextPage, completion: {
            (result, error) in
            if let e = error{
                self.error = e
                self.resultMovies = nil
            }else{
                if nextPage == 1 {self.resultMovies = result! }else{
                    let updateResult = ResultMoviesDao.updateResult(self.resultMovies!, newResult: result!)
                    self.error = updateResult.1 != nil ? updateResult.1! : nil
                    self.resultMovies = updateResult.0 != nil ? updateResult.0! : nil
                    
                }
                
            }
        })
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
    
    func logout(currentUser: User) {
        let logout = UserDao.deleteUser(currentUser.id)
        if let e = logout.1{
            self.error = e
        }
    }
}
