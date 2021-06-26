//
//  MovieList.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import SwiftUI

struct MovieList: View {
    
    @State var movies: [Movie] = []
    
    var body: some View {
        
        List(movies) { movieItem in
            MovieRow(movie: movieItem)
        }.onAppear {
            //API request
            APIService().loadData { movies in
                self.movies = movies
            }
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
    Movie(id: 1, poster_path: nil, original_title: "Filme 1", release_date: "2021", overview: "", genre_ids: []),
    Movie(id: 2, poster_path: nil, original_title: "Filme 2", release_date: "2020", overview: "", genre_ids: []),
    Movie(id: 3, poster_path: nil, original_title: "Filme 3", release_date: "2019", overview: "", genre_ids: []),
    Movie(id: 4, poster_path: nil, original_title: "Filme 4", release_date: "2018", overview: "", genre_ids: []),
    Movie(id: 5, poster_path: nil, original_title: "Filme 5", release_date: "2017", overview: "", genre_ids: [])
    
]
