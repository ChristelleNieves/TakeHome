//
//  API.swift
//  Takehome
//
//  Created by Christelle Nieves on 8/7/21.
//

import Foundation

public class API {
    
    // Fetch data from API
    func fetchCampigns(completionHandler: @escaping ([Campaign]) -> Void) {
        
        // Set URL
        guard let url = URL(string: API_Endpoint.baseURL) else { return }
        
        // Create task
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            // Handle error
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            // Handle response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected error fetching data: \(response.debugDescription)")
                return
            }
            
            // Handle data
            if let data = data,
               let campaignData = try? JSONDecoder().decode(Response.self, from: data) {
                completionHandler(campaignData.campaigns)
            }
        })
        
        // Resume task
        task.resume()
    }
}
