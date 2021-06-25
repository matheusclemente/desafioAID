//
//  MovieRow.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import SwiftUI

struct MovieRow: View {
    var movie : Movie
    
    var body: some View {
        HStack {
            
            Text(movie.title)
            Spacer()
            Text(movie.releaseYear)
        }
        .padding()
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        let previewMovie = Movie(posterPath: nil, title: "Nome do filme", releaseDate: "2021", overview: "Resumo do filme", genresId: [])
        MovieRow(movie: previewMovie)
    }
}
