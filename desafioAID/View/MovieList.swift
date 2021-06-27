//
//  MovieList.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import SwiftUI

struct MovieList: View {
    
    @State var movies: [Movie] = []
    let requester = APIService()
    
    var body: some View {
        NavigationView {
            List(movies) { movieItem in
                let imageData = requester.loadImageData(url: movieItem.posterUrl)
                
                NavigationLink(destination: MovieDetails(movie: movieItem, imageData: imageData)){
                    MovieRow(movie: movieItem, imageData: imageData)
                }
            }
            .onAppear {
                //API request
                requester.loadPopularMoviesData { movies in
                    self.movies = movies
                }
            }
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}

