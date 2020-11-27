//
//  ViewController.swift
//  Randog
//
//  Created by Ilya Vinogradov on 11/24/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var breedPicker: UIPickerView!
    
    var breeds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        breedPicker.dataSource = self
        breedPicker.delegate = self
        
        DogAPI.requestBreedsList(completionHandler: handleBreedListResponse(breeds:error:))
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
    
    func handleBreedListResponse(breeds: [String]?, error: Error?) {
        if let breeds = breeds {
            self.breeds = breeds
            
            DispatchQueue.main.async { [self] in
                breedPicker.reloadAllComponents()
            }
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row],completionHandler: handleRandomImageResponse(dogImage:error:))
    }
}
