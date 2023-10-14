import Foundation
import Alamofire

struct Film: Decodable {
    let title: String
    let release_date: String
    let opening_crawl: String
    let director: String
    let starships: [String]
}


func getFilmURL(for filmNumber: Int) -> URL {
  let filmURLString = "https://swapi.dev/api/films/\(filmNumber)/?format=json"
  return URL(string: filmURLString)!
}


