import Foundation
import Alamofire

struct StarShipModel:Codable {
    let name: String
    let model: String
    let manufacturer: String
    let cost_in_credits: String
    let length: String
    let max_atmosphering_speed: String
    let crew: String
    let passengers: String
    let cargo_capacity: String
    let consumables: String
    let hyperdrive_rating: String
    let MGLT: String
    let starship_class: String
   
}

func getStarShipUrl(for url: String) -> URL {
  let filmURLString = url
  return URL(string: filmURLString)!
}
