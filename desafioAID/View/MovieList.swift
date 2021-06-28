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
    @State private var connectionErrorAlert: Bool = false
    @State private var searchErrorAlert: Bool = false
    let requester = APIService()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search a movie", text: $searchText, onCommit: {
                    requester.loadSearchedMovies(title: searchText) { movies, sucess  in
                        if !sucess {
                            connectionErrorAlert = true
                        } else if movies.isEmpty {
                            print("Error")
                            searchErrorAlert = true
                        } else {
                            self.movies = movies
                        }
                    }
                }).padding()
                .alert(isPresented: $searchErrorAlert) {
                    Alert(title: Text("Sem resultados"), message: Text("Nenhum filme foi encontrado. Use outra palavra-chave e tente novamente") , dismissButton: .default(Text("Ok")))
                }
                
                
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
        }.alert(isPresented: $connectionErrorAlert) {
            Alert(title: Text("Erro"), message: Text("Falha ao conectar ao banco de dados. Verifique sua conexão ou tente novamente mais tarde") , dismissButton: .default(Text("Ok")))
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}

