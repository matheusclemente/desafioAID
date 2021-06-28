//
//  desafioAIDTests.swift
//  desafioAIDTests
//
//  Created by Matheus Azevedo on 25/06/21.
//

import XCTest
@testable import desafioAID

class desafioAIDTests: XCTestCase {

    private var testMovie: Movie!
    
    override func setUpWithError() throws {
        testMovie = Movie(id: 123, poster_path: "/some_poster_path", original_title: "A movie title", release_date: "2021-01-01", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", genre_ids: [1, 2, 3])
    }

    override func tearDownWithError() throws {
        testMovie = nil
    }


    func testMovieFullPosterUrl() {
        //Given
        XCTAssertEqual(testMovie.poster_path, "/some_poster_path")
        
        //When
        let movieFullUrl = testMovie.posterUrl
        
        //Then
        XCTAssertEqual(movieFullUrl, "https://www.themoviedb.org/t/p/w440_and_h660_face/some_poster_path")
    }
    
    func testMovieReleaseYear() {
        //Given
        XCTAssertEqual(testMovie.release_date, "2021-01-01")
        
        //When
        let movieYear = testMovie.releaseYear
        
        //Then
        XCTAssertEqual(movieYear, "2021")
    }
    
    func testEmptyMovieReleaseDate() {
        //Given
        let movie = Movie(id: 0, poster_path: "path", original_title: "title", release_date: nil, overview: "overview", genre_ids: [])
        XCTAssertNil(movie.release_date)
        
        //When
        let movieYear = movie.releaseYear
        
        //Then
        XCTAssertEqual(movieYear, "----")
    }
    
}
