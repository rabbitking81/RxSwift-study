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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }
}
