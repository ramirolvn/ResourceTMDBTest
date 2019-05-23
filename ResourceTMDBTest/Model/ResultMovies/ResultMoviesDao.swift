import Foundation
import RealmSwift

class ResultMoviesDao{
    class func updateResult(_ oldResult: ResultMovies, newResult: ResultMovies) -> (ResultMovies?,String?){
        let moviesAux = oldResult.movies
        for m in newResult.movies{
            moviesAux.append(m)
        }
        if moviesAux.count == 0 { return (nil, "Erro ao pegar filmes!")}
        oldResult.movies = moviesAux
        oldResult.total_pages = newResult.total_pages
        oldResult.total_results = newResult.total_results
        oldResult.lastPage = newResult.lastPage
        return(oldResult,nil)
        
    }
}



