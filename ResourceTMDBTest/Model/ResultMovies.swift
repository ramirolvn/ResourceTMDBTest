import Foundation
import SwiftyJSON

struct ResultMovies {
    private(set) public var total_pages: Int!
    private(set) public var total_results: Int!
    private(set) public var lastPage: Int!
    private(set) public var movies: [Movie]? = nil
    
    init?(result: JSON) {
        guard let totalPage =  result["total_pages"].int else{return nil}
        guard let total_results =  result["total_results"].int else{return nil}
        guard let page =  result["page"].int else{return nil}
        guard let movies =  result["results"].array else{return nil}
        var moviesAux = [Movie]()
        for m in movies{
            if let movie = Movie(movie: m){
                moviesAux.append(movie)
            }
        }
        if moviesAux.count == 0 { return nil}
        self.movies = moviesAux
        self.total_pages = totalPage
        self.total_results = total_results
        self.lastPage = page
    }
    
    init?(resultAntigo: ResultMovies, resultAtual: ResultMovies) {
        var moviesAux = resultAntigo.movies!
        for m in resultAtual.movies!{
            moviesAux.append(m)
        }
        if moviesAux.count == 0 { return nil}
        self.movies = moviesAux
        self.total_pages = resultAtual.total_pages
        self.total_results = resultAtual.total_results
        self.lastPage = resultAtual.lastPage
    }
    
    
}
