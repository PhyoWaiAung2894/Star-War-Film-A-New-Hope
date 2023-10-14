//
//  Utils.swift
//  Star War Film(A New Hope)
//
//  Created by PhyoWai Aung on 10/14/23.
//

import Foundation

class Utils{
    static func getTotalFilmUrls() -> [URL]{
        var filmUrls: [URL] = [];
        let filmNumbers: [Int] = URLS.totalFilmNumbers;
        
        let _ = filmNumbers.map { filmNumber in
            if let filmUrl = URL(string: "https://swapi.dev/api/films/\(filmNumber)/?format=json"){
                filmUrls.append(filmUrl);
            }
        }
        
        return filmUrls;
    }
}
