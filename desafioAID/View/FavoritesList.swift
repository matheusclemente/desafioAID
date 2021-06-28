//
//  FavoritesList.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 27/06/21.
//

import SwiftUI

struct FavoritesList: View {
    
    @State private var movies: [Movie] = []
    let requester = APIService()
    
    // Persistence
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var favorites: FetchedResults<FavoritedMovie>
    
    var body: some View {
        NavigationView {
            VStack {
                    
                List(favorites) { favoritedItem in
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
                }
                .onAppear {
                    //Load database
                    }
                }
            }
        }    
}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
    }
}
