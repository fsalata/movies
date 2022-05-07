//
//  MoviesRepository.swift
//  Movies
//
//  Created by Fabio Salata on 07/05/22.
//

import Foundation

@globalActor
final actor MoviesRepository {
    let client: APIClient
    
    static let shared = MoviesRepository()
    
    private init() {
        let moviesAPI = MoviesApi()
        let client = APIClient(api: moviesAPI)
        self.client = client
    }
}

extension MoviesRepository {
    func fetchUpcomingMovies(page: Int = 1) async throws -> (MoviesModel, URLResponse) {
        try await client.request(target: UpcomingMoviesTarget.movies(page: page))
    }
    
    func fetchMoviesGenres() async throws -> (GenresModel, URLResponse) {
        try await client.request(target: GenresTarget.genres)
    }
}
