import Foundation
class MoviesViewModel {
    private(set) public var error: String?
    private(set) public var resultMovies: ResultMovies? {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    private var dataService: DataService
    var didFinishFetch: (() -> ())?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func fetchMovies(page: Int) {
        dataService.fetchMovies(page: page, completion: {
            (result, error) in
            if let e = error{
                self.error = e
                self.resultMovies = nil
            }else{
                self.error = nil
                if page == 1 {self.resultMovies = result! }else{
                    //updateResult -- Depois fazer uma classe de manejo do model
                    self.resultMovies = ResultMovies(resultAntigo: self.resultMovies!, resultAtual: result!)
                }
                
            }
        })
    }
}
