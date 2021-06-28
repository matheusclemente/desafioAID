//
//  MovieList.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import SwiftUI

struct MovieList: View {
    
    @State private var movies: [Movie] = []
    @State private var searchText: String = ""
    @State private var searchErrorAlert: Bool = false
    let requester = APIService()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search a movie", text: $searchText, onCommit: {
                    requester.loadSearchedMovies(title: searchText) { movies in
                        if movies.isEmpty {
                            print("Error")
                            searchErrorAlert = true
                        } else {
                            self.movies = movies
                        }
                    }
                }).padding()
                
                
                List(movies) { movieItem in
                    let imageData = requester.loadImageData(url: movieItem.posterUrl)
                    
                    NavigationLink(destination: MovieDetails(movie: movieItem, imageData: imageData)){
                        MovieRow(movie: movieItem, imageData: imageData)
                    }
                }
                .onAppear {
                    if self.movies.isEmpty { //only go for popular movies if no search was made
                        requester.loadPopularMoviesData { movies in
                            self.movies = movies
                        }
                    }
                }
            }
        }.alert(isPresented: $searchErrorAlert) {
            Alert(title: Text("Erro"), message: Text("Houve um erro ao buscar filmes, por favor tente novamente") , dismissButton: .default(Text("Ok")))
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}

