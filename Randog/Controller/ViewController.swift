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
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                let url = json["message"] as! String
                print(url)
            } catch {
                print(error)
            }
        }
        task.resume()
    }


}

