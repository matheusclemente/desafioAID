//
//  FavoritesList.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 27/06/21.
//

import SwiftUI

struct FavoritesList: View {
    
    @State private var movies: [Movie] = []
    @State private var searchText: String = ""
    @State private var favoritesList: [FavoritedMovie] = []
    @State private var searchErrorAlert: Bool = false
    let requester = APIService()
    
    
    // Persistence
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var favorites: FetchedResults<FavoritedMovie>
    
    var body: some View {
        NavigationView {
            VStack {
                    
                TextField("Search a favorite", text: $searchText, onCommit: {
                    guard searchText != "" else {
                        self.favoritesList = Array(favorites)
                        return
                    }
                    var searchedItens: [FavoritedMovie] = []
                    for item in favorites {
                        if item.title!.lowercased().contains(searchText.lowercased()) {
                            searchedItens.append(item)
                        }
                    }
                    if searchedItens.isEmpty {
                        print("search error")
                        searchErrorAlert = true
                    } else {
                        self.favoritesList = searchedItens
                    }
                }).padding()
                
                List(favoritesList) { favoritedItem in
                    let movieItem = Movie(id: Int(favoritedItem.id),
                                          poster_path: favoritedItem.posterPath,
                                          original_title: favoritedItem.title ?? "",
                                          release_date: favoritedItem.releaseDate,
                                          overview: favoritedItem.overview ?? "",
                                          genre_ids: favoritedItem.genreId ?? [])
                    
                    let imageData = requester.loadImageData(url: movieItem.posterUrl)
                    
                    NavigationLink(destination: MovieDetails(movie: movieItem, imageData: imageData)){
                        MovieRow(movie: movieItem, imageData: imageData)
                    }
                }.onAppear {
                    self.favoritesList = Array(favorites)
                }
            }
        }.alert(isPresented: $searchErrorAlert) {
            Alert(title: Text("Erro"), message: Text("Nenhum favorito encontrado, por favor tente novamente") , dismissButton: .default(Text("Ok")))
        }
    }
}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
    }
}
