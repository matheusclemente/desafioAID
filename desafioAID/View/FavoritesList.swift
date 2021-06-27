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
    
    var body: some View {
        NavigationView {
            VStack {
                    
                List(movies) { movieItem in
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
