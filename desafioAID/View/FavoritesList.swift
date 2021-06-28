//
//  FavoritesList.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 27/06/21.
//

import SwiftUI

enum SortOption {
    case none
    case nameUp
    case nameDown
    case releaseYearUp
    case releaseYearDown
}

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
    
    @State private var selectedSort: SortOption = SortOption.none
    
    var body: some View {
        NavigationView {
            VStack {
                
                Picker("Order by", selection: $selectedSort) {
                    Text("Title(inc)").tag(SortOption.nameUp)
                    Text("Title(dec)").tag(SortOption.nameDown)
                    Text("Year(inc)").tag(SortOption.releaseYearUp)
                    Text("Year(dec)").tag(SortOption.releaseYearDown)
                }.pickerStyle(MenuPickerStyle())
                .onChange(of: selectedSort, perform: { value in
                   sortList(by: value)
                })
                
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
    
    private func sortList(by value: SortOption) {
        switch value {
        case .nameUp:
            favoritesList.sort {$0.title! < $1.title!}
        case .nameDown:
            favoritesList.sort {$0.title! > $1.title!}
        case .releaseYearUp:
            favoritesList.sort {$0.releaseDate! < $1.releaseDate!}
        case .releaseYearDown:
            favoritesList.sort {$0.releaseDate! > $1.releaseDate!}
        default:
            break
        }
    }
}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
    }
}
