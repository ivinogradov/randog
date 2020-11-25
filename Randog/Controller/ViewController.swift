//
//  ViewController.swift
//  Randog
//
//  Created by Ilya Vinogradov on 11/24/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            print(imageData)
        }
        task.resume()
    }


}

