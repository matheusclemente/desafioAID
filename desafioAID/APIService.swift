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
    func loadData(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=3364f96fa6acefbd524335c6cc0a4932&language=en-US&page=1") else {
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
}
