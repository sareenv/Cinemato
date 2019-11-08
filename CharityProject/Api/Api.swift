//
//  Api.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 06/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import Foundation

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
    
    
    func downloadMovies(completionHandler: @escaping (ApiErrors?, Movies?) -> ()){
        let session = URLSession.shared
        let baseUrl = "https://api.themoviedb.org/3/"
        let apiKey = "?api_key=48011e814c676dd12ae5d6e76288b2ae"
        let language = "&language=en-US"
        let adult = "&include_adult=false"
        let popularMoviesRelativeUrlPath = "movie/popular"
        
        let moviesUrlString = baseUrl + popularMoviesRelativeUrlPath + apiKey + language + adult
        
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
