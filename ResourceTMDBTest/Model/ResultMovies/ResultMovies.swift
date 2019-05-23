import Foundation
import SwiftyJSON
import RealmSwift

class ResultMovies : Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var total_pages: Int = 0
    @objc dynamic var total_results: Int = 0
    @objc dynamic var lastPage: Int = 0
    var movies = List<Movie>()
    
    required convenience init?(result: JSON) {
        self.init()
        guard let totalPage =  result["total_pages"].int else{return nil}
        guard let total_results =  result["total_results"].int else{return nil}
        guard let page =  result["page"].int else{return nil}
        guard let movies =  result["results"].array else{return nil}
        let moviesAux = List<Movie>()
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
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}
