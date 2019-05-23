import Foundation
import SwiftyJSON
import RealmSwift

class Movie : Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var vote_count:Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var poster_pathURL: String = ""
    @objc dynamic var original_title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var vote_average: Float = 0.0
    @objc dynamic var genre: String? = ""
    @objc dynamic var release_date: String? = nil
    
    required convenience init?(movie: JSON) {
        self.init()
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
        self.poster_pathURL = "https://image.tmdb.org/t/p/w400"+poster_path
        self.original_title = original_title
        self.vote_average = vote_average
        self.overview = overview
        if let genres = movie["genres"].array, genres.count > 0{
            self.genre = genres[0]["name"].string
        }
        self.release_date = movie["release_date"].string
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
