//
//  Api.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 06/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import Foundation
import UIKit

/* Singleton Pattern
    The class below shows the singleton pattern, as shown below the init method of the class
    is private so, the user cannot directly create the instance of the class. We need toaccess the static property called instance with instantiate the class and cannot be override. Therefore, there only exist one instance of this class.
 
 URL Session - Referance source
 https://developer.apple.com/documentation/foundation/urlsession
 The library allows the developers to make http request to the api endpoints.
 */

class Api{
    private init(){}
    static let instance = Api()
    
    enum ApiErrors: Error {
        case jsonParseError, networkError, noDataError
    }
    
    func downloadMovieCast(id: Int, completionHandler: @escaping (ApiErrors?, Cast?) -> ()) {
        let session = URLSession.shared
        let baseUrl = "https://api.themoviedb.org/3/"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let castRelativePath = "movie/\(id)/credits"
        let url = baseUrl + castRelativePath + apiKey
        guard let castUrl = URL(string: url) else { return }
        
        session.dataTask(with: castUrl) { (data, resp, error) in
            if(error != nil){
                return
            }
            guard let data = data else { return }
            guard let movieCast = try? JSONDecoder().decode(Cast.self, from: data) else {
                completionHandler(.jsonParseError, nil)
                return
            }
            completionHandler(nil, movieCast)
        }.resume()
    }
    
    func downloadWallImages(id: Int, completionHandler: @escaping (ApiErrors?, MovieImages?) -> ()){
        let session = URLSession.shared
        let baseUrl = "https://api.themoviedb.org/3/"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let imagesRelativePath = "movie/\(id)/images"
        let url = baseUrl + imagesRelativePath + apiKey
        guard let imagesUrl = URL(string: url) else { return }

        session.dataTask(with: imagesUrl) { (data, resp, error) in
            if(error != nil){
                return
            }
            guard let data = data else { return }
            guard let imageCovers = try? JSONDecoder().decode(MovieImages.self, from: data) else {
                completionHandler(.jsonParseError, nil)
                return
            }
           
            completionHandler(nil, imageCovers)
        }.resume()
    }
    
    
    func searchTVShows(tvShowName: String, completionHandler: @escaping (ApiErrors?, TVShows?) -> () ) {
        let baseUrl = "https://api.themoviedb.org/3"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let language = "&language=en-US"
        let relativePath = "/search/tv"
        let query = "&query=\(tvShowName)"
        let url = baseUrl + relativePath
            + apiKey + language + query
        guard let tvShowsUrl = URL(string: url) else { return }
        let session = URLSession.shared
        
        session.dataTask(with: tvShowsUrl) { (data, response, error) in
            if (error != nil) {
               completionHandler(.networkError, nil)
               return
            }
            guard let data = data else { return }
            guard let movies = try? JSONDecoder().decode(TVShows.self, from: data) else {
                completionHandler(.jsonParseError, nil)
                return
            }
            completionHandler(nil, movies)
            
        }.resume()
    }
    
    func downloadTrendingShows(completionHandler: @escaping (ApiErrors?, TVShows?) -> () ) {
        let baseUrl = "https://api.themoviedb.org/3"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let language = "&language=en-US"
        let relativePath = "/trending/tv/week"
       
        let url = baseUrl + relativePath
            + apiKey + language
        print(url)
        guard let tvShowsUrl = URL(string: url) else { return }
        let session = URLSession.shared
        
        session.dataTask(with: tvShowsUrl) { (data, response, error) in
            if (error != nil) {
               completionHandler(.networkError, nil)
               return
            }
            guard let data = data else { return }
            guard let movies = try? JSONDecoder().decode(TVShows.self, from: data) else {
                completionHandler(.jsonParseError, nil)
                return
            }
            completionHandler(nil, movies)
            
        }.resume()
    }
    
    
    func downloadMovies(pageNumber: Int, completionHandler: @escaping (ApiErrors?, Movies?) -> ()){
        let session = URLSession.shared
        let baseUrl = "https://api.themoviedb.org/3/"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let language = "&language=en-US"
        let adult = "&include_adult=true"
        let popularMoviesRelativeUrlPath = "movie/popular"
        let pageQuery = "&page=\(pageNumber)"
        
        let moviesUrlString = baseUrl + popularMoviesRelativeUrlPath + apiKey + language + adult + pageQuery
        
        
        guard let moviesUrl = URL(string: moviesUrlString) else { return }
        
        session.dataTask(with: moviesUrl) { (data, response, error) in
            if (error != nil) {
               completionHandler(.networkError, nil)
               return
            }
            guard let data = data else { return }
            guard let movies = try? JSONDecoder().decode(Movies.self, from: data) else {
                completionHandler(.jsonParseError, nil)
                return
            }
            completionHandler(nil, movies)
            
        }.resume()
    }
    
    
    func searchMovies(movieSearchTerm: String, completionHandler:@escaping (ApiErrors?, Movies?) -> () ) {
        let session = URLSession.shared
        let baseUrl = "https://api.themoviedb.org/3/"
        let relativePath = "search/movie"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let query = "&query=\(movieSearchTerm)"
        let searchMovieTermUrlString = baseUrl + relativePath + apiKey + query
        guard let searchMovieTermUrl = URL(string: searchMovieTermUrlString) else { return }
        session.dataTask(with: searchMovieTermUrl) { (data, resp, error) in
            if (error != nil) {
                completionHandler(.networkError, nil)
                return
            }
            guard let data = data else { return }
            guard let movies = try? JSONDecoder().decode(Movies.self, from: data) else {
                completionHandler(.jsonParseError, nil)
                return
            }
            completionHandler(nil, movies)
        }.resume()
    }
    
    
    func downloadSimilarMovies(movieId: Int, completionHandler: @escaping (ApiErrors?, Movies?)->()){
        let session = URLSession.shared
        let baseUrl = "https://api.themoviedb.org/3/"
        let similarPath = "movie/\(movieId)/recommendations"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let searchSimilarUrlString = baseUrl + similarPath + apiKey
        guard let searchSimilarUrl = URL(string: searchSimilarUrlString) else { return }
        
        session.dataTask(with: searchSimilarUrl) { (data, response, error) in
                   if (error != nil) {
                       completionHandler(.networkError, nil)
                       return
                   }
                   guard let data = data else { return }
                   
               guard let trendingData = try? JSONDecoder().decode(Movies.self, from: data) else {
                       completionHandler(.jsonParseError, nil)
                       return
                   }
                   completionHandler(nil, trendingData)
        }.resume()
    }
    
    func downloadTrailers(movieId: Int, completionHandler: @escaping (ApiErrors?, Trailers?)->()) {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=48011e814c676dd12ae5d6e76288b2ae"
        guard let trailerUrl = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: trailerUrl) { (data, response, error) in
            if (error != nil) {
                completionHandler(.networkError, nil)
                return
            }
            guard let data = data else { return }
            
        guard let trendingData = try? JSONDecoder().decode(Trailers.self, from: data) else {
                completionHandler(.jsonParseError, nil)
                return
            }
            completionHandler(nil, trendingData)
        }.resume()
    }
    
    func downloadTVShows() {
        
    }
    
    func downloadTrendingMovies(completionHandler: @escaping (ApiErrors?, Movies?)->()){
        let session = URLSession.shared
        let baseUrl = "https://api.themoviedb.org/3/"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let language = "&language=en-US"
        let adult = "&include_adult=false"
        let trendingRelativeUrlPath = "trending/movie/week"
        let query = ""
        let trendingUrlString = baseUrl + trendingRelativeUrlPath + apiKey + language + adult + query
        guard let trendingUrl = URL(string: trendingUrlString) else { return }
        session.dataTask(with: trendingUrl) { (data, response, error) in
            if (error != nil) {
                completionHandler(.networkError, nil)
                return
            }
            guard let data = data else { return }
            
        guard let trendingData = try? JSONDecoder().decode(Movies.self, from: data) else {
                completionHandler(.jsonParseError, nil)
                return
            }
            completionHandler(nil, trendingData)
        }.resume()
    }
}
