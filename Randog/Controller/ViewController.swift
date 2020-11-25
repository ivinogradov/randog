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
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(dogImage:error:))
    }

    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.dogImage.image = image
        }
    }
    
    func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        guard let imageUrl = URL(string: dogImage?.message ?? "") else {
            return
        }
        
        DogAPI.requestImageFile(url: imageUrl, completionHandler: handleImageFileResponse(image:error:))
    }
}

