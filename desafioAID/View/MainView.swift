//
//  MainView.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 27/06/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MovieList()
                .tabItem {
                    Label("Movies", systemImage: "list.dash")
                }
            
            FavoritesList()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
