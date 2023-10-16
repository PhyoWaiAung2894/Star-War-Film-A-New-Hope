import Foundation
import Alamofire

struct StarWarFilmModel: Codable {
    let results : [Film]
    
    init(results: [Film]) {
        self.results = results
    }
    
    struct Film: Codable {
        
        let title : String
        let release_date : String
        let opening_crawl : String
        let director: String
        let starships : [String]
    }
}



