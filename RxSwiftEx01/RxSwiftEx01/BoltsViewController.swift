//
//  BoltsViewController.swift
//  RxSwiftEx01
//
//  Created by danny on 2020/10/30.
//

import UIKit
import BoltsSwift

class BoltsViewController: UIViewController {
    private var counter: Int = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }
    
    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil
        
        boltsLoadImage(from: LARGER_IMAGE_URL)
            .continueWith { task in
                DispatchQueue.main.async {
                    self.imageView.image = task.result
                }
            }
    }
    
    private func boltsLoadImage(from imageUrl: String) -> Task<UIImage> {
        let taskCompletionSource = TaskCompletionSource<UIImage>()
        asyncLoadImage(from: imageUrl) { (image) in
            guard let image = image else {
                taskCompletionSource.cancel()
                return
            }
            taskCompletionSource.set(result: image)
        }
        return taskCompletionSource.task
    }
}
