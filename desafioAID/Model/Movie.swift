//
//  Movie.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let poster_path: String?
    let original_title: String
    let release_date: String?
    let overview: String
    let genre_ids: [Int]
    
    var releaseYear: String {
        String(release_date?.prefix(4) ?? "----")
    }
    var posterUrl: String {
        "https://www.themoviedb.org/t/p/w440_and_h660_face" + (poster_path ?? "")
    }
    var isFavorited: Bool {
        false
    }
}
