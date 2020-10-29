//
//  PromiseViewController.swift
//  RxSwiftEx01
//
//  Created by danny on 2020/10/30.
//

import UIKit
import PromiseKit

class PromiseViewController: UIViewController {
    private var counter: Int = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }
    
    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil
        
        promiseLoadImage(from: LARGER_IMAGE_URL)
            .done { image in
                self.imageView.image = image
            }
            .catch { (error) in
                print(error.localizedDescription)
            }
    }
    
    private func promiseLoadImage(from imageUrl: String) -> Promise<UIImage?> {
        return Promise<UIImage?>() { seal in
            asyncLoadImage(from: imageUrl) { image in
                seal.fulfill(image)
            }
        }
    }
}
