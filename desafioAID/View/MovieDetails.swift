//
//  MovieDetails.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 26/06/21.
//

import SwiftUI

struct MovieDetails: View {
    var movie : Movie
    var imageData: Data
    @State private var isFavorited = false
    @State private var genreText = ""
    
    let imageWidth: CGFloat = 220.0
    let imageHeight: CGFloat = 330.0
    
    let requester = APIService()

    // Persistence
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var favorites: FetchedResults<FavoritedMovie>

    var body: some View {
        ScrollView {
            VStack {
             
                if let movie = favorites.first(where: {$0.id == movie.id}) { //checks if movie is already favorited
                    Button("Unfavorite") {
                        deleteFavorite(movie)
                    }
                } else {
                    Button("Favorite") {
                        addFavorite()
                    }
                }
                
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: imageHeight)

                Text(movie.original_title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
                Text(movie.releaseYear)
                    .font(.subheadline)
                
                Text(genreText)
                    .font(.headline)
                    

                Text(movie.overview)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    
            }
            .padding()
            .onAppear {
                //Set favorite toggle acording to movie status
                self.isFavorited = movie.isFavorited
                
                requester.loadGenreList { genreList in
                    var array: [String] = []
                    for id in movie.genre_ids {
                        if let name = genreList.first(where: {$0.id == id})?.name {
                            array.append(name)
                        }
                    }
                    genreText = array.joined(separator: ", ")
                }
            }
        }
    }
    
    private func addFavorite() {
        let newFavorite = FavoritedMovie(context: viewContext)
        newFavorite.id = Int64(movie.id)
        newFavorite.posterPath = movie.poster_path
        newFavorite.title = movie.original_title
        newFavorite.releaseDate = movie.release_date
        newFavorite.overview = movie.overview
        newFavorite.genreId = movie.genre_ids
        
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Database error: \(error)")
        }
    }
    
    private func deleteFavorite(_ favoritedMovie: FavoritedMovie) {
        viewContext.delete(favoritedMovie)
        
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Database error: \(error)")
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        let previewMovie = Movie(id: 0, poster_path: nil, original_title: "Nome do filme", release_date: "2021", overview: "Resumo do filme", genre_ids: [])
        MovieDetails(movie: previewMovie, imageData: Data())
    }
}
