//
//  WeatherAPI.swift
//  Weather App
//
//  Created by Oğuzhan Varsak on 27.06.2020.
//  Copyright © 2020 Oğuzhan Varsak. All rights reserved.
//

import UIKit
import Foundation

class WeatherAPI {
    
    private let openWeatherMapAPIKey = "522ce424e744dab8b11548be4221b5e6"
    
    func getWeather(lat : Double, lon: Double, completion: @escaping (Forecast) -> Void) {
        
        let queryItems = [URLQueryItem(name: "lat", value: lat.description), URLQueryItem(name: "lon", value: lon.description), URLQueryItem(name: "APPID", value: openWeatherMapAPIKey)]
        var URLComps = URLComponents(string: "http://api.openweathermap.org/data/2.5/forecast")!
        URLComps.queryItems = queryItems
        
        let url = URLComps.url!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            do {
                let weatherItems = try JSONDecoder().decode(Forecast.self, from: data!)
                
                completion(weatherItems)
            } catch {
                print("JSON error: \(error)")
            }
        }
        task.resume()
    }
    
    
}
