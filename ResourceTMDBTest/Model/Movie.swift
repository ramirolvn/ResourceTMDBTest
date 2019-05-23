import Foundation
import SwiftyJSON

struct Movie {
    private(set) public var id:Int!
    private(set) public var vote_count:Int!
    private(set) public var title: String = ""
    private(set) public var poster_pathURL: String = ""
    private(set) public var original_title: String = ""
    private(set) public var overview: String = ""
    private(set) public var vote_average: Float!
    private(set) public var genre: String? = ""
    private(set) public var release_date: String? = nil
    
    init?(movie: JSON) {
        guard let id = movie["id"].int else {return nil}
        guard let vote_count = movie["vote_count"].int else {return nil}
        guard let title = movie["title"].string else {return nil}
        guard let poster_path = movie["poster_path"].string else {return nil}
        guard let original_title = movie["original_title"].string else {return nil}
        guard let overview = movie["overview"].string else {return nil}
        guard let vote_average = movie["vote_average"].float else {return nil}
        
        self.id = id
        self.vote_count = vote_count
        self.title = title
        self.poster_pathURL = "https://image.tmdb.org/t/p/w200"+poster_path
        self.original_title = original_title
        self.vote_average = vote_average
        self.overview = overview
        self.genre = movie["genres"].array?[0]["name"].string
        self.release_date = movie["release_date"].string
    }
}
