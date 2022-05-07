//
//  UpcomingScreen.swift
//  Movies
//
//  Created by Fabio Salata on 16/04/22.
//

import SwiftUI

struct UpcomingScreen: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @StateObject var viewModel = UpcomingMoviesViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.movies) { movie in
                    AsyncImage(url: movie.getPosterUrl()) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Text(movie.title)
                    }
                    .onAppear {
                        let index = viewModel.movies.firstIndex { $0 == movie }
                        if index == viewModel.movies.count - 1 {
                            Task {
                                await viewModel.fetchMoreMovies()
                            }
                        }
                    }

                }
            }
        }
        .task {
            await viewModel.fetchMovieData()
        }
    }
}

struct UpcomingScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingScreen()
    }
}
