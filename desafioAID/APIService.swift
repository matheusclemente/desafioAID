//
//  APIService.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 26/06/21.
//

import Foundation

struct RequestResult: Codable {
    let results: [Movie]
    let total_results: Int
    let page: Int
}

class APIService {
    
    let api_key = "3364f96fa6acefbd524335c6cc0a4932"
    
    func loadPopularMoviesData(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)") else {
            print("Invalid endpoint")
            return
        }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Invalid data")
                return
            }
            if let result = try? JSONDecoder().decode(RequestResult.self, from: data) {
                DispatchQueue.main.async {
                    //print(result)
                    completion(result.results)
                }
                return
            } else {
                print("Invalid result")
            }
        }.resume()
    }
    
    func loadSearchedMovies(title: String, completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=3364f96fa6acefbd524335c6cc0a4932&query=\(title)") else {
            print("Invalid endpoint")
            completion([])
            return
        }
        
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Invalid data")
                completion([])
                return
            }
            if let result = try? JSONDecoder().decode(RequestResult.self, from: data) {
                DispatchQueue.main.async {
                    //print(result)
                    completion(result.results)
                }
                return
            } else {
                print("Invalid result")
                completion([])
            }
        }.resume()
    }
    
    func loadImageData(url: String) -> Data {
        guard let imageUrl = URL(string: url) else { return Data() }
        guard let data = try? Data(contentsOf: imageUrl) else {
            return Data()
        }
        return data
    }
    
}
