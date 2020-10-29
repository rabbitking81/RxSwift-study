//
//  AsyncViewController.swift
//  RxSwiftEx01
//
//  Created by danny on 2020/10/29.
//

import UIKit

class AsyncViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    private var counter: Int = 0
    private let IMAGE_URL = "https://picsum.photos/1280/720/?random"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }
    
    @IBAction func onLoadSync(_ sender: Any) {
        let image = loadImage(from: IMAGE_URL)
        imageView.image = image
    }
    
    @IBAction func onLoadAsync(_ sender: Any) {
        DispatchQueue.global().async {
            let image = self.loadImage(from: self.IMAGE_URL)
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    private func loadImage(from imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        let image = UIImage(data: data)
        return image
    }
    
}
