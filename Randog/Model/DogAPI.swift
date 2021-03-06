//
//  DogAPI.swift
//  Randog
//
//  Created by Ilya Vinogradov on 11/24/20.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
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
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: self.Endpoint.randomImageForBreed(breed).url) { (data, response, networkError) in
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
    
    class func requestBreedsList(completionHandler: @escaping ([String]?, Error?) -> ()) {
        //request list of breeds
        let allBreedsTask = URLSession.shared.dataTask(with: self.Endpoint.listAllBreeds.url) {
        (data, response, networkError) in
            guard let data = data else {
                completionHandler(nil, networkError)
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let breedsData = try decoder.decode(DogBreeds.self, from: data)
                completionHandler(breedsData.breeds.keys.map({$0}), nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        allBreedsTask.resume()
    }
}
