//
//  networkManager.swift
//  openData Camara federal
//
//  Created by victor mont-morency on 16/12/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    // Example method to fetch forecast data
    func fetchForecastData(completion: @escaping (Result<ForecastResponse, Error>) -> Void) {
        guard let url = URL(string: "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept") // Add the Accept header for JSON
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure data is received
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Decode the JSON
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(.success(forecastResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start the network call
        task.resume()
    }
}
