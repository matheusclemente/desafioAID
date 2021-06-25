//
//  Movie.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import Foundation

struct Movie: Identifiable {
    let id = UUID()
    let posterPath: String?
    let title: String
    let releaseDate: String
    
    let overview: String
    let genresId: [Int]
    var releaseYear: String {
        String(releaseDate.prefix(4))
    }
    
    
}
