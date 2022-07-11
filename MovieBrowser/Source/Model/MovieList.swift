//
//  MovieList.swift
//  MovieBrowser
//
//  Created by Raveen Surabhi on 6/26/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class MovieList {
    

    private var dataAccessManager: MovieAPI?
    var movieSuccess: (() -> ())?
    var movieError: ((NetworkError?) -> ())?
    
    var totalPages: Int?
    
    private var movieList: [Movie] = [Movie]() {
        didSet {
            self.movieSuccess?()
        }
    }
    private var error: NetworkError? {
        didSet {
            self.movieError?(error)
        }
    }
    
    required init( apiService: MovieAPI?) {
        self.dataAccessManager = apiService
    }
    
    func getTotalMovies() -> Int {
        return movieList.count
    }
    func resetMovies() {
        return movieList.removeAll()
    }
    func getCellViewModel( at indexPath: IndexPath ) -> Movie {
        return movieList[indexPath.row]
    }
    func initFetch(url: String) {
        dataAccessManager?.getMoviesList(url: url, completion: { [weak self] (movieContainer, error) in
         self?.processFetchedData(movieContainer: (movieContainer as? MovieContainer)!, error: error)
        })
        
    }
    private func processFetchedData( movieContainer: MovieContainer , error: NetworkError?) {
        guard error == nil else {
            self.error = error!
            return
        }
        let total = self.movieList + movieContainer.results
        self.movieList = total
    }
    
}


