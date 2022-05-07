//
//  UpcomingMoviesViewModel.swift
//  Movies
//
//  Created by Fabio Salata on 16/04/22.
//

import Foundation

final class UpcomingMoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    var genres: [Genre] = []
    
    var page = 1
    
    let repository = MoviesRepository.shared
}

extension UpcomingMoviesViewModel {
    @MainActor func fetchMovieData() async {
        async let moviesData = await fetchMovies()
        async let genresData = await fetchGenres()
        
        (movies, genres) = await (moviesData, genresData)
    }
    
    @MainActor func fetchMoreMovies() async {
        page += 1
        
        let movies = await fetchMovies(page: page)
        
        self.movies += movies
    }
}

private extension UpcomingMoviesViewModel {
    func fetchGenres() async -> [Genre] {
        let genres = try? await repository.fetchMoviesGenres().0.genres
        return genres ?? []
    }
    
    func fetchMovies(page: Int = 1) async -> [Movie] {
        let movies = try? await repository.fetchUpcomingMovies(page: page).0.results
        return movies ?? []
    }
}

