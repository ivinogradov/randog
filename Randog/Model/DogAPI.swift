//
//  DogAPI.swift
//  Randog
//
//  Created by Ilya Vinogradov on 11/24/20.
//

import Foundation

class DogAPI {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
        
    }
}
