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
    
    let imageWidth: CGFloat = 220.0
    let imageHeight: CGFloat = 330.0

    var body: some View {
        ScrollView {
            VStack {
             
                Toggle("Favorite", isOn: $isFavorited)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                
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

                Text(movie.overview)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    
            }
            .padding()
            .onAppear {
                //Set favorite toggle acording to movie status
                self.isFavorited = movie.isFavorited
            }
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        let previewMovie = Movie(id: 0, poster_path: nil, original_title: "Nome do filme", release_date: "2021", overview: "Resumo do filme", genre_ids: [])
        MovieDetails(movie: previewMovie, imageData: Data())
    }
}
