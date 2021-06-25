//
//  MovieList.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import SwiftUI

struct MovieList: View {
    var body: some View {
        List {
            MovieRow(movie: placeholderMovies[0])
            MovieRow(movie: placeholderMovies[1])
            MovieRow(movie: placeholderMovies[2])
            MovieRow(movie: placeholderMovies[3])
            MovieRow(movie: placeholderMovies[4])
            MovieRow(movie: placeholderMovies[0])
            MovieRow(movie: placeholderMovies[1])
            MovieRow(movie: placeholderMovies[2])
            MovieRow(movie: placeholderMovies[3])
            MovieRow(movie: placeholderMovies[4])
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}


//Test Data
var placeholderMovies = [
    Movie(posterPath: nil, title: "Filme 1", releaseDate: "2021", overview: "", genresId: []),
    Movie(posterPath: nil, title: "Filme 2", releaseDate: "2020", overview: "", genresId: []),
    Movie(posterPath: nil, title: "Filme 3", releaseDate: "2019", overview: "", genresId: []),
    Movie(posterPath: nil, title: "Filme 4", releaseDate: "2018", overview: "", genresId: []),
    Movie(posterPath: nil, title: "Filme 5", releaseDate: "2017", overview: "", genresId: [])
    
]
