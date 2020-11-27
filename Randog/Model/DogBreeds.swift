//
//  DogBreeds.swift
//  Randog
//
//  Created by Ilya Vinogradov on 11/26/20.
//

import Foundation

struct DogBreeds: Codable {
    let status: String
    let breeds: [String: [String]]
    
    enum CodingKeys: String, CodingKey {
        case breeds = "message"
        case status
    }
}
