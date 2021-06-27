//
//  MovieRow.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import SwiftUI

struct MovieRow: View {
    var movie : Movie
    var imageData: Data
    
    let imageWidth: CGFloat = 44.0
    let imageHeight: CGFloat = 66.0
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: imageData) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageWidth, height: imageHeight)
            Text(movie.original_title)
            Spacer()
            Text(movie.releaseYear)
        }
        .padding()
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        let previewMovie = Movie(id: 0, poster_path: nil, original_title: "Nome do filme", release_date: "2021", overview: "Resumo do filme", genre_ids: [])
        MovieRow(movie: previewMovie, imageData: Data())
    }
}
