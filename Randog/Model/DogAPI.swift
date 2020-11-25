//
//  DogAPI.swift
//  Randog
//
//  Created by Ilya Vinogradov on 11/24/20.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let imageTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        }
        imageTask.resume()
    }
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: self.Endpoint.randomImageFromAllDogsCollection.url) { (data, response, networkError) in
            guard let data = data else {
                completionHandler(nil, networkError)
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                completionHandler(imageData, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
