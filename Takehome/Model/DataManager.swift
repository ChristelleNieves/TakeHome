//
//  DataManager.swift
//  Takehome
//
//  Created by Christelle Nieves on 8/7/21.
//

import Foundation
import UIKit

public class DataManager {
    
    let api = API()
    var campaigns = [Campaign]()
    
    // Trigger an API request to fetch all campaigns and populate the campaigns array
    func getAllCampaignsFromAPI(completionHandler: @escaping () -> Void) {
        api.fetchCampigns(completionHandler: { allCampaigns in
            self.campaigns = allCampaigns
            
            DispatchQueue.main.async {
                completionHandler()
            }
        })
    }
    
    // Download a file from a remote URL
    func downloadFile(fileURLString: String) {
        
        // Create destination url
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
        
        // Create source url for the file that will be downloaded
        let fileURL = URL(string: fileURLString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        
        // Create task
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading file.")
            }
        }
        
        task.resume()
    }
    
    // Return a UIImage from a URL endpoint
    func getImageFromURL(urlString: String) -> UIImage {
        var image = UIImage()
        guard let url = URL(string: urlString) else { return image }
        let data = try? Data(contentsOf: url)
        
        if let imageData = data {
            image = UIImage(data: imageData) ?? UIImage()
        }
        
        return image
    }
}
